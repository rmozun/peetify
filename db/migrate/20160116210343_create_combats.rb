class CreateCombats < ActiveRecord::Migration
  def change
    create_table :combats do |t|
      t.integer :fighter1_id
      t.integer :fighter2_id
      t.datetime :date
      t.integer :winner_id

      t.timestamps null: false
    end
  end
end
