class RemoveTvShowIdFromEpisodes < ActiveRecord::Migration[8.0]
  def change
    remove_column :episodes, :tv_show_id, :integer
  end
end
