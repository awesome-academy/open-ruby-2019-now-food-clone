class ManagerController < ActionController::Base
  before_action :authenticate_user!
  before_action :verify_manager

  def manager_user
    return if current_user.manager?
    flash[:danger] = t(".not_role")
    redirect_to root_url
  end

  protected

  def verify_manager
    redirect_to root_path unless current_user.manager?
  end
end
