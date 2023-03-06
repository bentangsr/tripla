class ActivitiesSerializer
  include JSONAPI::Serializer

  attributes :id, :user_id, :created_at, :updated_at
  attribute :sleep_at do |object|
    object.sleep_at.strftime("%Y-%m-%d %H:%M") if object.sleep_at.present?
  end
  attribute :wake_up_at do |object|
    object.wake_up_at.strftime("%Y-%m-%d %H:%M") if object.wake_up_at.present?
  end
end