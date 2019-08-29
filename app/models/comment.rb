class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :commentable, polymorphic: true
  has_many :sub_comments, class_name: Comment.name, foreign_key: :parent_comment_id, dependent: :destroy
  belongs_to :parent_comment, class_name: Comment.name, optional: true
end
