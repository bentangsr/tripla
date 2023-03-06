class ClockOperationsSerializer
  include JSONAPI::Serializer

  attributes :id, :created_at, :updated_at
  attribute :clock_at do |object|
    object.clock_at.strftime("%H:%M")
  end
end