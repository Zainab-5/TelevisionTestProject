class Movie < ApplicationRecord
  has_many :availabilities, as: :available_for, dependent: :destroy
end
