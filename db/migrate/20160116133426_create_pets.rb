class CreatePets < ActiveRecord::Migration
  def change
    create_table :pets do |t|
      t.string :name
      t.references :user, index: true, foreign_key: true
      t.integer :age
      t.integer :sex
      t.string :breed

      t.timestamps null: false
    end
  end
end
