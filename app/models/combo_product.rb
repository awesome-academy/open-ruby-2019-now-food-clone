class ComboProduct < ApplicationRecord
  belongs_to :product
  belongs_to :combo
end
