class TimeWatched < ApplicationRecord
  belongs_to :user
  belongs_to :channel_program

  validates :seconds_watched, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
end
