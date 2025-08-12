class CreateEpisodes < ActiveRecord::Migration[8.0]
  def change
    create_table :episodes do |t|
      t.references :season, null: false, foreign_key: true
      t.references :tv_show, foreign_key: true
      t.string :title
      t.integer :number
      t.integer :year
      t.integer :duration_in_seconds

      t.timestamps
    end
  end
end
