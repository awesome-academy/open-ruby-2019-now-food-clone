class AddCostToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :cost, :integer
  end
end
