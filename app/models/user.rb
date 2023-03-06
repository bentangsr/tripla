class User < ApplicationRecord
  has_many :activities

  followability
  validates :name, uniqueness: true

  def collect_pending_requests
    self.pending_requests.includes(:followable)
  end

  def collect_follow_requests
    self.follow_requests.includes(:followerable)
  end

  def past_week_activities
    self.activities
        .where("created_at >= ? AND created_at <= ?", 1.week.ago, DateTime.now)
        .order("created_at DESC")
  end
end