class District < ApplicationRecord
  belongs_to :province

  scope :by_province_id, ->(province_id){where province_id: province_id}
end
