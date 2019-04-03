require 'ostruct'
require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do
  describe '#current_user' do
    context 'when user is logged in' do
      let(:user_object) {OpenStruct.new(id: 1, name: 'test_user')}      

      before do
        session[:user_id] = 1

        allow(User)
          .to receive(:find)
          .and_return(user_object)
      end

      it 'returns the user object' do
        expect(controller.current_user).to eq(user_object)
      end

      it 'sets session' do
        expect(session[:user_id]).to eq(1)
      end
    end

    context 'when user is not logged in' do
      it 'returns nil' do
        expect(controller.current_user).to eq(nil)
      end
    end
  end
  describe '#require_user' do
    context 'When user is not logged in' do
      before do
        allow(controller)
          .to receive(:current_user)
          .and_return(nil)
      end
        
      it 'redirects to login page' do
        expect(response).to redirect_to(login_path)
      end
    end
  end
end

