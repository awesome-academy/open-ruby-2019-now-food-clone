class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :name
      t.float :price
      t.integer :status, default: 1
      t.references :store, foreign_key: true
    end
  end
end
