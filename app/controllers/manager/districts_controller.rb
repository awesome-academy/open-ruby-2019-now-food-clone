class Manager::DistrictsController < ManagerController
  load_and_authorize_resource
  
  def index
    @districts = District.by_province_id params[:id]

    respond_to :js
  end
end
