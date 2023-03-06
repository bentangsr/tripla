class Activity < ApplicationRecord
  belongs_to :user

  validates :user_id, presence: true
  validates :wake_up_at, presence: true, on: :create
  validates :wake_up_at, comparison: { less_than: :sleep_at }, if: :sleep_at_and_wake_up_at_present?
  validate :wake_up_at_cannot_be_in_the_past, :wake_up_at_exist_on_clock_operation, if: :wake_up_at
  validate :sleep_at_exist_on_clock_operation, if: :sleep_at

  def self.find_today
    self.where("DATE(created_at) = ?", Date.today)
  end

  # validate
  private
  def sleep_at_and_wake_up_at_present?
    sleep_at.present? && wake_up_at.present?
  end

  def wake_up_at_cannot_be_in_the_past
    if wake_up_at.to_date < DateTime.now.to_date
      errors.add(:wake_up_at, "can't be in the past")
    end
  end

  def wake_up_at_exist_on_clock_operation
    if ClockOperation.select(:id).where(clock_at: self.wake_up_at).blank?
      errors.add(:wake_up_at, "not found in clock_operation, please create first")
    end
  end

  def sleep_at_exist_on_clock_operation
    if ClockOperation.select(:id).where(clock_at: self.sleep_at).blank?
      errors.add(:sleep_at, "not found in clock_operation, please create first")
    end
  end
end
