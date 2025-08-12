class ChannelProgram < ApplicationRecord
  has_many :availabilities, as: :available_for, dependent: :destroy
  has_many :schedules
  belongs_to :channel
end
