module ManageCache
  def delete_current_cache
    unless Rails.env.test?
      Rails.cache.redis.keys.select do |key|
        if key.include?(self.class.to_s.downcase)
          Rails.cache.delete(key)
        end
      end
    end
  end
end