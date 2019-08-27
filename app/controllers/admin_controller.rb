class AdminController < ActionController::Base
  def admin_user
    return if current_user.admin?
    flash[:danger] = t(".not_role")
    redirect_to root_url
  end
end
