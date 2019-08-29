class Bill < ApplicationRecord
  enum status: {cancel: 0, in_processing: 1, packing: 2, shipping: 3}

  belongs_to :user
  belongs_to :store
  has_many :bill_details, dependent: :destroy
end
