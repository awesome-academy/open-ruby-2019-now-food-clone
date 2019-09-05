class Manager::DistrictsController < ManagerController
  def index
    @districts = District.by_province_id params[:id]
    respond_to :js
  end
end
