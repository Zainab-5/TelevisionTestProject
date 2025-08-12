class CreateAvailabilities < ActiveRecord::Migration[8.0]
  def change
    create_table :availabilities do |t|
      t.references :app, null: false, foreign_key: true
      t.references :available_for, polymorphic: true, null: false # Points to Movie, TVShow, etc.

      t.string :country_code
      t.string :stream_url
      t.timestamps
    end
    add_index :availabilities, :country_code
  end
end
