class CreateBillDetails < ActiveRecord::Migration[5.2]
  def change
    create_table :bill_details do |t|
      t.references :bill, foreign_key: true
      t.references :bill_detailable, polymorphic: true, index: {name: :bill_detailable_index}
      t.integer :count
      t.float :price
    end
  end
end
