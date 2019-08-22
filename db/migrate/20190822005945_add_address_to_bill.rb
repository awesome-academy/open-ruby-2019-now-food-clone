class AddAddressToBill < ActiveRecord::Migration[5.2]
  def change
    add_column :bills, :address, :string
  end
end
