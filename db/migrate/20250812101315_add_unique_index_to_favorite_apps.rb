class AddUniqueIndexToFavoriteApps < ActiveRecord::Migration[8.0]
  def change
    add_index :favorite_apps, [ :user_id, :app_id ], unique: true
  end
end
