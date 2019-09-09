class AdminController < ActionController::Base
  before_action :authenticate_user!
  before_action :verify_admin

  def admin_user
    return if current_user.admin?
    flash[:danger] = t(".not_role")
    redirect_to root_url
  end

  protected

  def verify_admin
    redirect_to root_path unless current_user.admin?
  end
end
