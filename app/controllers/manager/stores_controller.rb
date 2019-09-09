class Manager::StoresController < ManagerController
  before_action :load_store, only: %i(edit update destroy)

  def index
    @stores = current_user.stores

    respond_to :js
  end

  def new
    @store = Store.new

    respond_to :js
  end

  def create
    @store = Store.new store_params

    if @store.save
      render json: {success: render_to_string(partial: "manager/stores/create",
        locals: {store: @store}, layout: false)}
    else
      render json: {errors: @store.errors}
    end
  end
  
  def edit
    respond_to :js
  end

  def update
    if @store.update_attributes store_params
      render json: {success: @store}
    else
      render json: {errors: @store.errors}
    end
  end

  def destroy
    @store.destroy

    respond_to :js
  end

  def get_districts
    @districts = District.by_province_id params[:id]
    respond_to :js
  end

  private

  def store_params
    params.require(:store).permit Store::STORE_PARAMS
  end

  def load_store
    @store = Store.find_by_id params[:id]

    return if @store
    flash[:danger] = t(".not_exits")
    redirect_to root_path
  end
end
