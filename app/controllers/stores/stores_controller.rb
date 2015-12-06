class Stores::StoresController < StoresController

  def index
    store_name = params[:store_name]
    @store = EDrugstore.where(name: store_name).first

    @incidents = @store.incidents
  end

  def incident
    @incident = Incident.find(params[:id])
    @store = @incident.e_drugstore
  end

end
