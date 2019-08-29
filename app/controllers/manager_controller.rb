class ManagerController < ActionController::Base
  def manager_user
    return if current_user.manager?
    flash[:danger] = t(".not_role")
    redirect_to root_url
  end
end
