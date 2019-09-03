class AddDefaultToComment < ActiveRecord::Migration[5.2]
  def change
    change_column :comments, :parent_comment_id, :integer, default: 0
  end
end
