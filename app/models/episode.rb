class Episode < ApplicationRecord
  belongs_to :season
  has_many :availabilities, as: :available_for, dependent: :destroy

  validates :number, presence: true,
                     uniqueness: { scope: :season_id, message: "must be unique within the same season" }
end
