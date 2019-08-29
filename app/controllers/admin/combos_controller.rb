class Admin::combosController < AdminController
  before_action :is_manager

  def index
    @search = combo.ransack params[:search]
    @combos = @search.result.page(params[:page]).per Settings.admin.combo.num_in_page
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

  def is_manager
    redirect_to root_path unless current_user.manager?
  end
end
