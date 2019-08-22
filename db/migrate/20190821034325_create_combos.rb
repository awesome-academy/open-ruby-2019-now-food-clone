class CreateCombos < ActiveRecord::Migration[5.2]
  def change
    create_table :combos do |t|
      t.string :name
      t.integer :status, default: 1
      t.float :price
      t.references :store, foreign_key: true
    end
  end
end
