class Manager::HomesController < ManagerController
  skip_load_and_authorize_resource
  
  def index; end
end
