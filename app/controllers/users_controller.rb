class UsersController < ApplicationController
  include CsmHelper
  before_action :authorize_request, except: :signup
  before_action :find_user, except: %i[signup]

  def signup
    @user = User.new(user_params)
    if @user.save
      render json: @user, serializer: UserSerializer, status: :created
    else
      render json: { errors: @user.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.permit(:name, :username, :email, :password)
  end
end
