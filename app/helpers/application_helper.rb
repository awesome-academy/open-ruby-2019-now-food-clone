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
    imageable.images.thumbnail.present? ? "#{imageable.images.thumbnail.first.url}" : "#{Settings.upload.default}"
  end

  def get_thumbnails imageable
    imageable.images.thumbnail
  end

  def get_images imageable
    imageable.images.image
  end

  def count_thumbnails imageable
    imageable.images.thumbnail.count
  end

  def count_images imageable
    imageable.images.image.count
  end

  def count_stores
    Store.pluck(:id).count
  end

  def count_comments commentable
    commentable.comments.count
  end

  def number_to_vnd number
    "#{number_to_currency(number,unit: "",separator: ",",delimiter: ".")} #{Settings.unit}"
  end

  def address_by_store_id store_id
    Store.find_by(id: store_id).address
  end

  def sum_money bill_details
    bill_details.inject(0){|sum, n| sum + n.count * n.bill_detailable_price}
  end
end
