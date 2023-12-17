class AuthenticationController < ApplicationController
  before_action :authorize_request, except: :login

  def login
    if params[:email].blank?
      render json: { error: 'Email not given' }, status: :unauthorized
      return
    end
    @user = User.find_by_email(params[:email])
    if @user.blank?
      render json: { error: 'Email Invalid' }, status: :unauthorized
      return
    end
    if @user.authenticate(params[:password])
      token = JsonWebToken.encode(user_email: @user.email)
      time = Time.now + 24.hours.to_i
      render json: { token: token, exp: time.strftime("%m-%d-%Y %H:%M"),
                     username: @user.username }, status: :ok
    else
      render json: { error: 'Invalid credentials' }, status: :unauthorized
    end
  end

  private

  def login_params
    params.permit(:email, :password)
  end
end
