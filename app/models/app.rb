class App < ApplicationRecord
  has_many :availabilities
  has_many :favorite_apps
  has_many :users, through: :favorite_apps
end
