class AddUniqueIndexToEpisodes < ActiveRecord::Migration[8.0]
  def change
    add_index :episodes, [ :season_id, :number ], unique: true
  end
end
