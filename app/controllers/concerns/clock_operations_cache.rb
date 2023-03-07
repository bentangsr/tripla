require 'json'
module ClockOperationsCache
  def fetch_clock_operations
    clock_operations = Rails.cache.read("clockoperation")
    if clock_operations.nil?
      Rails.cache.fetch("clockoperation") do
        clock_operations = ClockOperationsSerializer.new(ClockOperation.all).serializable_hash.to_json
      end
    end
    return JSON.load clock_operations
  end
end

