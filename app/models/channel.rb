class Channel < ApplicationRecord
  has_many :availabilities, as: :available_for, dependent: :destroy
  has_many :channel_programs, dependent: :destroy
end
