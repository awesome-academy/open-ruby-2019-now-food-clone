class Combo < ApplicationRecord
  enum status: {in_active: 0, active: 1}

  belongs_to :store
  has_many :bill_details, as: :bill_detailable
  has_many :comments, as: :commentable
  has_many :combo_products
end
