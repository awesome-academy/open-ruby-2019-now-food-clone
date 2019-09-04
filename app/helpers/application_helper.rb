module ApplicationHelper
  def get_index_page page = :page, key
    params[page].to_i * Settings.page.num_in_page + key + Settings.page.start
  end

  def get_index key
    key + Settings.page.start
  end

  def get_stores
    current_user.stores.pluck :address, :id
  end
end
