class Manager::BillsController < ManagerController
  before_action :load_bill, only: %i(show update destroy)

  def index
    @search = Bill.ransack params[:search]
    @bills = @search.result.page(params[:page])
      .by_store_ids(store_ids)
      .per Settings.manager.bill.num_in_page
  end

  def show; end

  def update
    if @bill.update_attributes status: params[:status]
      render json: {state: :success, status: :ok, data: @bill}
    else
      render json: {state: :errors, status: :not_found, data: @bill.errors}
    end
  end

  private

  def bill_params
    params.require(:bill).permit Bill::BILL_PARAMS
  end

  def store_ids
    current_user.store_ids
  end

  def load_bill
    @bill = Bill.find_by_id params[:id]

    return if @bill
    flash[:danger] = t(".not_exits")
    redirect_to root_path
  end
end
