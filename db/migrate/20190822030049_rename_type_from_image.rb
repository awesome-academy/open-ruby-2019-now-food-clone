class RenameTypeFromImage < ActiveRecord::Migration[5.2]
  def change
    rename_column :images, :type, :image_type
  end
end
