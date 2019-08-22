class Store < ApplicationRecord
  belongs_to :user
  belongs_to :district
  has_many :bills
  has_many :combos
  has_many :products
end
