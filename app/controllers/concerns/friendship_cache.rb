require 'json'
module FriendshipCache
  def fetch_pending_requests(user)
    pending_requests = Rails.cache.read("pending_request_user_#{user.id}")
    if pending_requests.nil?
      Rails.cache.fetch("pending_request_user_#{user.id}") do
        pending_requests = PendingRequestsSerializer.new(user.collect_pending_requests).serializable_hash.to_json
      end
    end
    return JSON.load pending_requests
  end

  def fetch_follow_requests(user)
    follow_requests = Rails.cache.read("follow_request_user_#{user.id}")
    if follow_requests.nil?
      Rails.cache.fetch("follow_request_user_#{user.id}") do
        follow_requests = FollowRequestsSerializer.new(user.collect_follow_requests).serializable_hash.to_json
      end
    end
    return JSON.load follow_requests
  end

  def fetch_followers(user)
    user_followers = Rails.cache.read("followers_user_#{user.id}")
    if user_followers.nil?
      Rails.cache.fetch("followers_user_#{user.id}") do
        user_followers = UsersSerializer.new(user.followers).serializable_hash.to_json
      end
    end
    return JSON.load user_followers
  end

  def fetch_following(user)
    user_following = Rails.cache.read("following_user_#{user.id}")
    if user_following.nil?
      Rails.cache.fetch("following_user_#{user.id}") do
        user_following = UsersSerializer.new(user.following).serializable_hash.to_json
      end
    end
    return JSON.load user_following
  end
end
