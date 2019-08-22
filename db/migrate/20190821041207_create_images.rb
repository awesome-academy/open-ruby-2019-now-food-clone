class CreateImages < ActiveRecord::Migration[5.2]
  def change
    create_table :images do |t|
      t.string :url
      t.string :alt
      t.integer :type
      t.references :imageable, polymorphic: true
    end
  end
end
