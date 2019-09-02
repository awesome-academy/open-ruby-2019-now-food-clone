module StoresHelper
  def get_provinces
    Province.pluck :name, :id
  end

  def get_distric_brothers store
    return nil if store.id.blank?
    District.get_district_by_province_id(store.district.province_id).
      pluck :name, :id
  end

  def stt_store_create
    current_user.stores.count
  end
end
