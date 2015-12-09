class Stores::EDrugsController < StoresController
  before_action :set_store

  def index

  end

  def show
    @drug = @store.e_drugs.find(params[:id])
  end

  private
    def set_store
      store_name = params[:store_name]
      @store = EDrugstore.where(name: store_name).first
    end

end
