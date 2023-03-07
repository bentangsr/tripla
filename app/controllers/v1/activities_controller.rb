class V1::ActivitiesController < ApplicationController
  include UsersCache
  before_action :set_user, only: [:create, :lastest, :my_friend, :show]
  before_action :set_friend, only: [:my_friend]

  def lastest
    render json: ActivitiesSerializer.new(@user.activities.last).serializable_hash.to_json
  end

  def create
    @activity = Api::BuildActivity.new(activity_params: activity_params).run
    if @activity[:error].zero?
      render json:{data: @activity[:message]}, status: :created
    else
      render json: {error: {status: 422, message: @activity[:message].flatten}}, status: :unprocessable_entity
    end
  end

  def my_friend
    if @user.following?(@friend)
      render json: fetch_friend_activities(@friend)
    else
      render json: {error: {status: 404, message: "You have not followed"}}, status: :not_found
    end
  end

  def show
    render json: fetch_my_activities(@user)
  end

  private

  def set_user
    @user= User.find_by_id(params[:user_id])
    if @user.blank?
      render json: {error: {status: 404, message: "User ID not found"}}, status: :not_found
    end
  end

  def set_friend
    @friend= User.find_by_id(params[:friend_id])
    if @friend.blank?
      render json: {error: {status: 404, message: "Friend ID not found"}}, status: :not_found
    end
  end

  def activity_params
    params.require(:activity).permit(:id, :user_id, :sleep_at, :wake_up_at)
  end
end

