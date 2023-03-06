class PendingRequestsSerializer
  include JSONAPI::Serializer

  attribute :user do |object|
    object.followable
  end
end