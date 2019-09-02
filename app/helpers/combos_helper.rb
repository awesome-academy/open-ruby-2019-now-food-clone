module CombosHelper
  def get_stores
    current_user.stores.pluck :address, :id
  end
end
