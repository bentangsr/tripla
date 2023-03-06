require 'json'
module UsersCache
  def fetch_users
    users = Rails.cache.read("user")
    if users.nil?
      Rails.cache.fetch("user") do
        users = UsersSerializer.new(User.all).serializable_hash.to_json
      end
    end
    return JSON.load users
  end

  def fetch_users_id(user)
    user_detail = Rails.cache.read("user_#{user.id}", expires_in: 10.minutes)
    if user_detail.nil?
      Rails.cache.fetch("user_#{user.id}") do
        user_detail = UsersSerializer.new(user).serializable_hash.to_json
      end
    end
    return JSON.load user_detail
  end

  def fetch_friend_activities(friend)
    friend_activities = Rails.cache.read("friend_activity_#{friend.id}", expires_in: 10.minutes)
    if friend_activities.nil?
      Rails.cache.fetch("friend_activity_#{friend.id}") do
        friend_activities = ActivitiesSerializer.new(friend.past_week_activities)
                                           .serializable_hash
                                           .to_json
      end
    end
    return JSON.load friend_activities
  end

  def fetch_my_activities(user)
    my_activities = Rails.cache.read("my_activity_#{user.id}", expires_in: 10.minutes)
    if my_activities.nil?
      Rails.cache.fetch("my_activity_#{user.id}") do
        my_activities = ActivitiesSerializer.new(user.activities)
                                           .serializable_hash
                                           .to_json
      end
    end
    return JSON.load my_activities
  end
end
