class FollowRequestsSerializer
  include JSONAPI::Serializer

  attribute :user do |object|
    object.followerable
  end
end