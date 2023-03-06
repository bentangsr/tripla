class ClockOperation < ApplicationRecord
  validates :clock_at, uniqueness: true
end