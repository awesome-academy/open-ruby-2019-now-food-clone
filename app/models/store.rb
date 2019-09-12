class Store < ApplicationRecord
  STORE_PARAMS = %i(address phone district_id user_id).freeze

  belongs_to :user
  belongs_to :district
  has_many :bills, dependent: :destroy
  has_many :combos, dependent: :destroy
  has_many :products, dependent: :destroy

  delegate :name, to: :district, prefix: true

  validates :address, presence: true
  validates :phone, presence: true
  validates :district_id, presence: true

  scope :by_province_id, ->(province_id){where(districts: {province_id: province_id})}
end
