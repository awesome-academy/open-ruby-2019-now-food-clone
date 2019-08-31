module CombosHelper
  def get_stores
    current_user.stores.pluck :address, :id
  end

  def get_combos
    current_user.stores.pluck :name, :id
  end

  def get_products
    current_user.products.pluck :name, :id
  end
end
