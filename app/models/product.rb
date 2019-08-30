class Product < ApplicationRecord
  enum status: {inactive: 0, active: 1}

  belongs_to :store
  has_many :combo_products, dependent: :destroy
  has_many :bill_details, as: :bill_detailable, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy
  has_one :anh, as: :imageable
  has_many :images, as: :imageable
end
