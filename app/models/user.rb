class User < ApplicationRecord
  USER_PARAMS = %i(phone address name email password password_confirmation role).freeze

  enum role: {normal: 0, admin: 1, manager: 2}
  
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable,
    :omniauthable, omniauth_providers: [:facebook]

  has_many :stores, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :bills, dependent: :destroy

  validates :address, presence: true, length:
    {minimum: Settings.user.min_address_length, maximum: Settings.user.max_address_length}
  validates :phone, presence: true, length:
    {maximum: Settings.user.max_phone_length}
  validates :name, presence: true, length:
    {minimum: Settings.user.min_name_length, maximum: Settings.user.max_name_length}

  class << self
    def from_omniauth auth
      where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
        user.email = auth.info.email
        user.password = Devise.friendly_token[Settings.user.min_password_length, Settings.user.max_password_length]
        user.name = auth.info.name
      end
    end
  end
end
