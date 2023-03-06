module Api
  class BuildActivity
    def initialize(activity_params: )
      @activity_params = activity_params
      @user = nil
      @message = {error: 0, message: []}
    end

    def run
      set_user
      create_data_activity
      return @message
    end

    private

    def set_user
      @user= User.find_by_id(@activity_params['user_id'])
      if @user.blank?
        @message[:error] = 1
        @message[:message].push("User ID no found")
        return @message
      end
    end

    def create_data_activity
      last_activity = @user.activities.last
      if last_activity.present? && last_activity.sleep_at.blank?
        last_activity.update(@activity_params.merge('wake_up_at': last_activity.wake_up_at))
        if last_activity.errors.present?
          @message[:error] = 1
          @message[:message].push(last_activity.errors.full_messages)
        else
          @message[:message].push("successfully updated activity")
        end
      else
        activity = Activity.new(@activity_params)
        if activity.save
          @message[:message].push("successfully created activity")
        else
          @message[:error] = 1
          @message[:message].push(activity.errors.full_messages)
        end
      end
    end
  end
end