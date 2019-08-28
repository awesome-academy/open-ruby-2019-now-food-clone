class User < ApplicationRecord
  enum role: {normal: 0, admin: 1, manager: 2}
  
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable,
    :omniauthable, omniauth_providers: [:facebook]

  has_many :stores
  has_many :comments
  has_many :bills

  class << self
    def new_with_session params, session
      tap do |user|
        if data = session["devise.#facebook_data"] &&
          session["devise.facebook_data"]["extra"]["raw_info"]
          next unless user.email.blank?
          user.email = data["email"]
        end
      end
    end

    def from_omniauth auth
      where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
        user.email = auth.info.email
        user.password = Devise.friendly_token[Settings.user.min_password_length, Settings.user.max_password_length]
        user.name = auth.info.name
      end
    end
  end
end
