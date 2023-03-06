class V1::UsersController < ApplicationController
  include UsersCache
  before_action :set_user, only: :show

  def index
    render json: fetch_users
  end

  def show
    render json: fetch_users_id(@user)
  end

  def create
    user = User.create(user_params)
    if user.valid?
      render json:{data: "successfully created user"}, status: :created
    else
      render json: {error: {status: 422, message: user.errors.full_messages}}, status: :unprocessable_entity
    end
  end

  private

  def set_user
    @user= User.find_by_id(params[:id])
    if @user.blank?
      render json: {error: {status: 404, message: "User ID not found"}}, status: :not_found
    end
  end

  def user_params
    params.require(:user).permit(:name)
  end
end