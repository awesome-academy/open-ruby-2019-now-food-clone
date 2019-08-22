class User < ApplicationRecord
  enum role: {normal: 0, admin: 1, manager: 2}

  has_many :stores
  has_many :comments
  has_many :bills
end
