class CreateSeasons < ActiveRecord::Migration[8.0]
  def change
    create_table :seasons do |t|
      t.references :tv_show, null: false, foreign_key: true
      t.string :title
      t.integer :number
      t.integer :year

      t.timestamps
    end
  end
end
