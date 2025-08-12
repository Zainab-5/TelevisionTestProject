class FavoriteApp < ApplicationRecord
  belongs_to :user
  belongs_to :app

  validates :position, numericality: { only_integer: true, greater_than: 0 }, allow_nil: true
  validates :app_id, uniqueness: { scope: :user_id, message: "has already been favorited by this user" }
end
