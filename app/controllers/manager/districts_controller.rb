class Manager::DistrictsController < ManagerController
  def index
    @districts = District.get_district_by_province_id params[:id]
    respond_to :js
  end
end
