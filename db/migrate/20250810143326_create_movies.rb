class CreateMovies < ActiveRecord::Migration[8.0]
  def change
    create_table :movies do |t|
      t.string :title
      t.integer :year
      t.integer :duration_in_seconds

      t.timestamps
    end
  end
end
