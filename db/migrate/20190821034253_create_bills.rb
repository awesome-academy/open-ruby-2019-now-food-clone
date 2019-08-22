class CreateBills < ActiveRecord::Migration[5.2]
  def change
    create_table :bills do |t|
      t.integer :status, default: 1
      t.references :user, foreign_key: true
      t.references :store, foreign_key: true

      t.timestamps
    end
  end
end
