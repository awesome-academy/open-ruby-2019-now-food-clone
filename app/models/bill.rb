class Bill < ApplicationRecord
  BILL_PARAMS = [:status, :store_id, :address, bill_details_attributes:
    [:bill_detailable_type, :bill_detailable_id, :count, :price]].freeze

  enum status: {in_processing: 0, packing: 1, shipping: 2, success: 3, cancel: 4}

  belongs_to :user
  belongs_to :store
  has_many :bill_details, dependent: :destroy

  delegate :name, to: :user, prefix: true
  delegate :address, to: :store, prefix: true

  accepts_nested_attributes_for :bill_details, reject_if: :all_blank,
  allow_destroy: true

  scope :by_store_ids, ->(store_ids){where store_id: store_ids}
end
