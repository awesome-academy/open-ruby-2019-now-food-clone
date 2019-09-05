class BillDetail < ApplicationRecord
  belongs_to :bill
  belongs_to :bill_detailable, polymorphic: true

  delegate :name, to: :bill_detailable, prefix: true

  scope :by_bill, ->(bill_id){where bill_id: bill_id}
end
