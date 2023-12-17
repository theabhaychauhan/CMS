require 'rails_helper'

RSpec.describe AdministratorController, type: :controller do
  before :all do
    3.times do |i|
      user = User.create!({
               username: "test_user_#{i}",
               email: "test_#{i}@email.com",
               password: 'password123',
               name: "TEST #{i}",
             })
    end
  end

  after :all do
    User.destroy_all
  end

  before :each do
    secret = Rails.application.secrets.json_web_token_secret
    encoding = 'HS512'
    request.headers["Authorization"] = JsonWebToken.encode( user_email: "test_0@email.com")
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

  describe 'POST #create_user' do
    before :each do
      post :create_user, params: {
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

  describe 'PUT #update_user' do
    before :each do
      @user = User.create!({
                      username: 'test_user_10',
                      email: 'test@email.com',
                      password: 'password123',
                      name: 'TEST',
                    })
      @name_before_update = @user.name
      post :update, params: {
                      username: 'test_user',
                      email: 'test@email.com',
                      password: 'password123',
                      name: 'TEST 1',
                    }
    end
    it 'updates the user' do
      expect(@user.reload.name).to_not(eq(@name_before_update))
      expect(@user.name).to(eq("TEST 1"))
    end
  end

  describe 'DELETE #delete_user' do
    before :each do
      @user = User.create!({
                      username: 'test_user_11',
                      email: 'test11@email.com',
                      password: 'password123',
                      name: 'TEST',
                    })
      @name_before_update = @user.name
      post :delete, params: {
                      email: 'test11@email.com'
                    }
    end
    it 'deletes the user' do
      expect(response).to have_http_status(:no_content)
    end
  end
end
