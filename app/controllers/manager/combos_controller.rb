class Manager::CombosController < ManagerController
  before_action :load_combo, only: %i(destroy)
  before_action :is_manager

  def index
    @search = Combo.ransack params[:search]
    @combos = @search.result.page(params[:page])
      .combo_of_current_user(combo_id_current_user)
      .per Settings.manager.combo.num_in_page
  end
  
  def destroy
    if @combo.destroy
      flash[:success] = t(".success")
    else
      flash[:danger] = t(".error")
    end
    redirect_to manager_combos_url
  end

  private

  def combo_id_current_user
    current_user.combos.pluck :id
  end

  def load_combo
    @combo = Combo.find_by_id params[:id]

    return if @combo
    flash[:danger] = t(".not_exits")
    redirect_to root_path
  end

  def is_manager
    redirect_to root_path unless current_user.manager?
  end
end
