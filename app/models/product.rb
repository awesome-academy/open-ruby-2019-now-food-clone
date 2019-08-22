class Product < ApplicationRecord
  enum status: {inactive: 0, active: 1}

  belongs_to :store
  has_many :combo_products
  has_many :bill_details, as: :bill_detailable
  has_many :comments, as: :commentable
end
