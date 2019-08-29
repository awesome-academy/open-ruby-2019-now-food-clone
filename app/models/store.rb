class Store < ApplicationRecord
  belongs_to :user
  belongs_to :district
  has_many :bills, dependent: :destroy
  has_many :combos, dependent: :destroy
  has_many :products, dependent: :destroy
end
