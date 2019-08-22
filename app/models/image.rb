class Image < ApplicationRecord
  enum type: {image: 0, thumbnail: 1}

  belongs_to :imageable, polymorphic: true
end
