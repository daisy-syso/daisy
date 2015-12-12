class Stores::DrugtypesController < StoresController
  before_action :set_store

  def drugs
    @drugs = @store.e_drugs.where(drug_type_id: params[:id])
  end

  private
    def set_store
      store_name = params[:store_name]
      @store = EDrugstore.where(name: store_name).first
    end

end
