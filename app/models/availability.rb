class Availability < ApplicationRecord
  belongs_to :app
  belongs_to :available_for, polymorphic: true

  validates :country_code, presence: true
  validates :app_id, uniqueness: {
    scope: [ :available_for_type, :available_for_id, :country_code ],
    message: "can only have one availability per content per country"
  }
end
