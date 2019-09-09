class Manager::CombosController < ManagerController
  before_action :load_combo, except: %i(index new create)
  before_action :load_products, only: %i(show)
  before_action :load_parent_comments, only: %i(show)

  def index
    @search = Combo.ransack params[:search]
    @combos = @search.result.includes(:images).page(params[:page])
      .combo_of_current_user(combo_id_current_user)
      .per Settings.manager.combo.num_in_page
  end

  def show
    @comment = Comment.new
  end

  def new
    @combo = Combo.new
  end

  def edit; end

  def create
    @combo = Combo.new combo_params

    if @combo.save
      flash[:success] = t(".success")
      redirect_to manager_combos_path
    else
      render :new
    end
  end

  def update
    if @combo.update_attributes combo_params
      flash[:success] = t(".success")
      redirect_to manager_combos_path
    else
      render :new
    end
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

  def combo_params
    params.require(:combo).permit Combo::COMBO_PARAMS
  end
  
  def load_combo
    @combo = Combo.find_by_id params[:id]

    return if @combo
    flash[:danger] = t(".not_exits")
    redirect_to root_path
  end

  def load_products
    @products = @combo.products
  end

  def load_parent_comments
    @parent_comments = @combo.comments.parent_comment
  end
end
