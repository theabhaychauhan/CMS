# spec/controllers/users_controller_spec.rb

require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'POST #signup' do
    before :each do
      User.destroy_all
    end
    context 'with valid parameters' do
      before :each do
        post :signup, params: {
                        username: 'test_user',
                        email: 'test@email.com',
                        password: 'password123',
                        name: 'TEST',
                      }
      end
      it 'creates a new user' do
        expect(response).to have_http_status(:created)
        expect(User.find(JSON.parse(response.body)["id"])).to(be_present)
      end
    end
  end
end
