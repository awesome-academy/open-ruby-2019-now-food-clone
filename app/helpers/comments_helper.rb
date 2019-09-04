module CommentsHelper
  def get_sub_comment comment
    Comment.this_parent_comment comment.id
  end
end
