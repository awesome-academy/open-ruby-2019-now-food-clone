class Manager::CommentsController < ManagerController
  skip_load_and_authorize_resource
  before_action :load_comment, only: %i(edit update destroy)

  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new comment_params
    @comment.save

    respond_to :js
  end
  
  def destroy
    @comment.destroy

    respond_to :js
  end
  
  private

  def comment_params
    params.require(:comment).permit Comment::COMMENT_PARAMS
  end
  
  def load_comment
    @comment = Comment.find_by_id params[:id]

    return if @comment
    flash[:danger] = t(".not_exits")
    redirect_to root_path
  end
end
