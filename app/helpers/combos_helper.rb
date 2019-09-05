module CombosHelper
  def get_combos
    current_user.stores.pluck :name, :id
  end

  def get_products
    current_user.products.pluck :name, :id
  end

  def get_count_in_combo_product combo_id, product_id
    ComboProduct.get_combo_product_by_combo_id_product_id(combo_id, product_id).count
  end
end
