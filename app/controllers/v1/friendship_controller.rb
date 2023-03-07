class V1::FriendshipController < ApplicationController
  include FriendshipCache

  before_action :set_user, only: [:followers, :following, :pending_requests, :follow_requests]
  before_action :set_sender_receiver, only: [:follow, :unfollow, :decline_follow, :remove_follow, :accept_follow]

  def follow
    @sender.send_follow_request_to(@receiver)
    if @sender.errors.blank?
      render json: {data: "successfully sent follow request"}, status: :created
    else
      render json: {error: {status: 422, message: @sender.errors.full_messages.last}}, status: :unprocessable_entity
    end
  end

  def unfollow
    @sender.unfollow(@receiver)
    if @sender.errors.blank?
      render json: {data: "successfully unfollow"}, status: :created
    else
      render json: {error: {status: 422, message: @sender.errors.full_messages.last}}, status: :unprocessable_entity
    end
  end

  def decline_follow
    @sender.decline_follow_request_of(@receiver)
    if @sender.errors.blank?
      render json: {data: "successfully decline follow request"}, status: :created
    else
      render json: {error: {status: 422, message: @sender.errors.full_messages.last}}, status: :unprocessable_entity
    end
  end

  def remove_follow
    @sender.remove_follow_request_for(@receiver)
    if @sender.errors.blank?
      render json: {data: "successfully remove follow request"}, status: :created
    else
      render json: {error: {status: 422, message: @sender.errors.full_messages.last}}, status: :unprocessable_entity
    end
  end

  def accept_follow
    @sender.accept_follow_request_of(@receiver)
    if @sender.errors.blank?
      render json: {data: "successfully accept follow request"}, status: :created
    else
      render json: {error: {status: 422, message: @sender.errors.full_messages.last}}, status: :unprocessable_entity
    end
  end

  def pending_requests
    @pending_requests = fetch_pending_requests(@user)
    if @pending_requests.present?
      render json: @pending_requests
    else
      render json: {error: {status: 422, message: ""}}, status: :unprocessable_entity
    end
  end

  def follow_requests
    @follow_requests = fetch_follow_requests(@user)
    if @follow_requests.present?
      render json: @follow_requests
    else
      render json: {error: {status: 422, message: ""}}, status: :unprocessable_entity
    end
  end

  def followers
    render json: fetch_followers(@user)
  end

  def following
    render json: fetch_following(@user)
  end

  private

  def set_sender_receiver
    @sender = User.find_by_id(params[:sender_id])
    @receiver = User.find_by_id(params[:receiver_id])

    if @sender.blank?
      render json: {error: {status: 404, message: "Sender ID not found"}}, status: :not_found
    end
    if @receiver.blank?
      render json: {error: {status: 404, message: "Receive ID not found"}}, status: :not_found
    end
  end

  def set_user
    @user = User.find_by_id(params[:user_id])
    if @user.blank?
      render json: {error: {status: 404, message: "User ID not found"}}, status: :not_found
    end
  end
end

