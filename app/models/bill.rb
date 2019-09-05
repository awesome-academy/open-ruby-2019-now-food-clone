class Bill < ApplicationRecord
  BILL_PARAMS = %i(status bill_id store_id address).freeze

  enum status: {in_processing: 0, packing: 1, shipping: 2, success: 3, cancel: 4}

  belongs_to :user
  belongs_to :store
  has_many :bill_details, dependent: :destroy

  delegate :name, to: :user, prefix: true
  delegate :address, to: :store, prefix: true

  scope :by_store_ids, ->(store_ids){where store_id: store_ids}
end
