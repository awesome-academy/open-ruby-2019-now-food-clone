class Admin::UsersController < AdminController
  before_action :load_user, only: %i(destroy)

  def index
    @search = User.ransack params[:search]
    @users = @search.result.page(params[:page]).per Settings.admin.user.num_in_page
  end

  def destroy
    if @user.destroy
      flash[:success] = t(".success")
    else
      flash[:danger] = t(".error")
    end
    redirect_to admin_users_url
  end

  private

  def load_user
    @user = User.find_by_id params[:id]
    
    return if @user
    flash[:danger] = t(".not_exits")
    redirect_to root_path
  end
end
