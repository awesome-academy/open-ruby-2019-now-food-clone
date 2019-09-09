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

  def get_thumnail imageable
    imageable.images.thumbnail.present? ? "#{imageable.images.thumbnail.first.url}" : "#{Settings.default}"
  end

  def get_images imageable, thumbnail
    if :thumbnail.eql? thumbnail
      imageable.images.thumbnail
    else
      imageable.images.image
    end
  end

  def number_to_vnd number
    "#{number_to_currency(number,unit: "",separator: ",",delimiter: ".")} #{Settings.unit}"
  end
end
