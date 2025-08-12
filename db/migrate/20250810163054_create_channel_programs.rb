class CreateChannelPrograms < ActiveRecord::Migration[8.0]
  def change
    create_table :channel_programs do |t|
      t.references :channel, null: false, foreign_key: true
      t.string :title

      t.timestamps
    end
  end
end
