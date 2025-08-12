class TvShow < ApplicationRecord
  has_many :availabilities, as: :available_for, dependent: :destroy
  has_many :seasons, dependent: :destroy
  has_many :episodes, through: :seasons
end
