class Comment < ApplicationRecord
  COMMENT_PARAMS = %i(content parent_comment_id content user_id commentable_type commentable_id).freeze

  belongs_to :user
  belongs_to :commentable, polymorphic: true
  has_many :sub_comments, class_name: Comment.name, foreign_key: :parent_comment_id, dependent: :destroy
  belongs_to :parent_comment, class_name: Comment.name, optional: true

  scope :parent_comment, ->{where parent_comment_id: Settings.zero}
  scope :this_parent_comment, ->(parent_comment_id){where parent_comment_id: parent_comment_id}
end
