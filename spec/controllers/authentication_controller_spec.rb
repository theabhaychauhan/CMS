require 'rails_helper'

RSpec.describe AuthenticationController, type: :controller do
  describe 'POST #login' do
    before :all do
      @user = User.new({
               username: 'test_user',
               email: 'test@email.com',
               password: 'password123',
               name: 'TEST',
             })
      @user.save!
    end

    after :all do
      @user.destroy
    end

    context "Valid Password" do
      before :each do
        post :login, params: { email: @user.email, password: 'password123' }
      end

      it 'returns a valid authentication token' do
        expect(response).to have_http_status(:ok)
        expect(response_json).to have_key('token')
        expect(response_json).to have_key('exp')
        expect(response_json).to have_key('username')
      end
    end

    context "Invalid Password" do
      before :each do
        post :login, params: { email: @user.email, password: 'password1233' }
      end

      it 'returns a valid authentication token' do
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  def response_json
    JSON.parse(response.body)
  end
end
