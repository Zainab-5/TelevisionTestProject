class CreateTimeWatcheds < ActiveRecord::Migration[8.0]
  def change
    create_table :time_watcheds do |t|
      t.references :user, null: false, foreign_key: true
      t.references :channel_program, null: false, foreign_key: true
      t.integer :seconds_watched

      t.timestamps
    end
  end
end
