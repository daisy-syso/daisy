class Stores::DrugtypesController < StoresController
  before_action :set_store

  def drugs
    @drug_type = DrugType.find(params[:id])
    @drugs = @store.e_drugs.where(drug_type_id: params[:id])
  end

  def sub_drugs
    @drug_type = DrugType.find(params[:id])
    @drugs = @store.e_drugs.where(drug_type_id2: params[:id])
  end

  def subsub_drugs
    @drug_type = DrugType.find(params[:id])
    @drugs = @store.e_drugs.where(drug_type_id3: params[:id])
  end

  private
    def set_store
      store_name = params[:store_name]
      @store = EDrugstore.where(name: store_name).first
    end

end
