require 'rails_helper'

RSpec.describe ManagerController, type: :controller do
  before :all do
    3.times do |i|
      user = User.create!({
               username: "test_user_#{i}",
               email: "test_#{i}@email.com",
               password: 'password123',
               name: "TEST #{i}",
               role: "manager"
             })
    end
  end

  after :all do
    User.destroy_all
  end

  before :each do
    secret = Rails.application.secrets.json_web_token_secret
    encoding = 'HS512'
    request.headers["Authorization"] = JsonWebToken.encode( user_email: "test_1@email.com")
  end
  describe 'GET #users' do
    context "Fetches all users" do
      context "With tag" do
        before :each do
          get :index, params: {
                          tag: "test"
                        }
          @body = JSON.parse(response.body)
        end

        it 'returns matched users' do
          expect(response).to have_http_status(:ok)
          expect(@body.first.keys).to(eq(["id", "username", "email", "created_at", "updated_at"]))
          expect(@body.count).to(eq(3))
        end
      end
      context "With role" do
        before :each do
          get :index, params: {
                          role: "administrator"
                        }
          @body = JSON.parse(response.body)
        end
        it 'returns matched users' do
          expect(response).to have_http_status(:ok)
          expect(@body.first.keys).to(eq(["id", "username", "email", "created_at", "updated_at"]))
          expect(@body.count).to(eq(1))
        end
      end
    end
  end
end
