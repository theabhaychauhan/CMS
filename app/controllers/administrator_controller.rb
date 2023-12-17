class AdministratorController < ApplicationController
  before_action :authorize_request
  before_action :authenticate_admin

  include CsmHelper

  def index
    users = User.all
    if params[:role].present?
      users = users.where(role: params[:role])
    end
    if params[:tag].present?
      search_tag = params[:tag]
      users = users.where("name LIKE ? OR email LIKE ?", "%#{search_tag}%", "%#{search_tag}%")
    end
    render json: users, each_serializer: UserSerializer, status: :ok
  end

  def create_user
    user = User.new(user_params)
    if user.save
      render json: user, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    user = User.find_by_email(user_params[:email])
    if user.blank?
      render json: { error: 'User not present' }, status: :unauthorized
      return
    end
    if user.update(user_params)
      render json: user, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def delete
    user = User.find_by_email(user_params[:email])
    if user.blank?
      render json: { error: 'User not present' }, status: :unauthorized
      return
    end
    user.destroy
    render json: user, status: :no_content
  end

  private

  def authenticate_admin
    unless current_user&.administrator?
      render json: { error: 'Unauthorized' }, status: :unauthorized
    end
  end

  def user_params
    params.permit(:email, :name, :username, :role, :username, :password, :password_confirmation)
  end
end
