class CreateStores < ActiveRecord::Migration[5.2]
  def change
    create_table :stores do |t|
      t.string :address
      t.string :phone
      t.references :user, foreign_key: true
      t.references :district, foreign_key: true
      t.string :start_time
      t.string :end_time

      t.timestamps
    end
  end
end
