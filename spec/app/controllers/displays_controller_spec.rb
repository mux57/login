require 'ostruct'
require 'rails_helper'
RSpec.describe DisplaysController, type: :controller do
	describe 'Get index' do
		context 'when user is logged in' do
			let(:user_object){OpenStruct.new(id: 1, name: 'yo yo', email: 'yo@email.com')}
			before do
				allow(controller)
				.to receive(:current_user)
				.and_return(user_object)
			end
			it 'display user details' do
				get :index
				expect(response).to render_template "index"
			end
		end

		context 'when user is not logged in' do
			it 'redirect to login' do
				get :index
				expect(response).to redirect_to(login_path)
			end
		end
	end
end
