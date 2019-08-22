class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  enum role: {normal: 0, admin: 1, manager: 2}

  has_many :stores
  has_many :comments
  has_many :bills
end
