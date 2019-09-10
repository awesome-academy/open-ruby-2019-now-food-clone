class Admin::UsersController < AdminController
  before_action :load_user, except: %i(index create new)

  def index
    @search = User.ransack params[:search]
    @users = @search.result.order_by_role.page(params[:page]).per Settings.admin.user.num_in_page
  end

  def new
    @user = User.new

    respond_to :js
  end

  def show
    respond_to :js
  end

  def edit
    respond_to :js
  end

  def update
    if @user.update_attributes user_params
      render json: {success: @user}
    else
      render json: {errors: @user.errors}
    end
  end

  def create
    @user = User.new user_params
    
    if @user.save
      render json: {success: render_to_string(partial: "admin/users/create",
        locals: {user: @user}, layout: false)}
    else
      render json: {errors: @user.errors}
    end
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
  
  def user_params
    params.require(:user).permit User::USER_PARAMS
  end

  def load_user
    @user = User.find_by_id params[:id]
    
    return if @user
    flash[:danger] = t(".not_exits")
    redirect_to root_path
  end
end
