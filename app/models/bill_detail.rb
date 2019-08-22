class BillDetail < ApplicationRecord
  belongs_to :bill
  belongs_to :bill_detailable, polymorphic: true
end
