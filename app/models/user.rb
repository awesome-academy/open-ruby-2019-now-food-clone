class User < ApplicationRecord
  enum role: {normal: 0, admin: 1, manager: 2}
  
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable

  has_many :stores
  has_many :comments
  has_many :bills
end
