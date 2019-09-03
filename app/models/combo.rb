class Combo < ApplicationRecord
  COMBO_PARAMS = [:name, :price, :store_id, combo_products_attributes:
    [:id, :combo_id, :product_id, :count, :_destroy]].freeze

  enum status: {in_active: 0, active: 1}

  belongs_to :store
  has_many :bill_details, as: :bill_detailable
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :combo_products, dependent: :destroy
  has_many :images, as: :imageable

  validates :name, presence: true, length:
    {minimum: Settings.combo.min_name_length, maximum: Settings.combo.max_name_length}
  validates :price, presence: true
  validates :store_id, presence: true

  accepts_nested_attributes_for :combo_products, reject_if: :all_blank,
    allow_destroy: true

  scope :combo_of_current_user, ->(combo_ids){where id: combo_ids}
end
