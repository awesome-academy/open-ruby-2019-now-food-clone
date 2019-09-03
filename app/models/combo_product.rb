class ComboProduct < ApplicationRecord
  belongs_to :product
  belongs_to :combo

  scope :get_combo_product_by_combo_id_product_id, ->(combo_id, product_id){
    where(combo_id: combo_id, product_id: product_id)}
end
