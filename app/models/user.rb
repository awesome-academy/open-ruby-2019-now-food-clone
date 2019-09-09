class User < ApplicationRecord
  USER_PARAMS = %i(phone address name email password password_confirmation role).freeze

  enum role: {normal: 0, manager: 1, admin: 2}
  
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable,
    :omniauthable, omniauth_providers: [:facebook]

  has_many :stores, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :bills, dependent: :destroy
  has_many :combos, through: :stores
  has_many :products, through: :stores

  validates :address, presence: true, length:
    {minimum: Settings.user.min_address_length,
    maximum: Settings.user.max_address_length}, allow_nil: true
  validates :phone, presence: true, length:
    {maximum: Settings.user.max_phone_length}, allow_nil: true
  validates :name, presence: true, length:
    {minimum: Settings.user.min_name_length,
    maximum: Settings.user.max_name_length}, allow_nil: true

  scope :order_by_role, ->{order role: :desc}

  private

  def new_with_session params, session
    tap do |user|
      if data = session["devise.#facebook_data"] &&
        session["devise.facebook_data"]["extra"]["raw_info"]
        next unless user.email.blank?
        user.email = data["email"]
      end
    end
  end

  class << self
    def from_omniauth auth
      where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
        user.email = auth.info.email
        user.password = Devise.friendly_token[Settings.user.min_password_length,
          Settings.user.max_password_length]
        user.name = auth.info.name
        user.image = auth.info.image
      end
    end
  end
end
