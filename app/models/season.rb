class Season < ApplicationRecord
  belongs_to :tv_show
  has_many :episodes
  has_many :availabilities, as: :available_for, dependent: :destroy
end
