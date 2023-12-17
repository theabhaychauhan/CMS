class ManagerController < ApplicationController
  before_action :authorize_request
  before_action :authenticate_manager

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

  private

  def authenticate_manager
    unless current_user&.manager?
      render json: { error: 'Unauthorized' }, status: :unauthorized
    end
  end
end
