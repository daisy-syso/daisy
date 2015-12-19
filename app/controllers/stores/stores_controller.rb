class Stores::StoresController < StoresController
  before_action :set_store

  def index
    @feedbacks = @store.feedbacks.order("created_at desc").page(1).per(5)

    @incidents = @store.incidents

    @drug_type_ids = @store.e_drugs.pluck(:drug_type_id)

    @drug_type = DrugType.find(@drug_type_ids.compact)

    # @drugs = @store.e_drugs

    # @drugs = @store.e_drugs.order("sales desc").limit(12)

    drug_type_id2s = @store.e_drugs.limit(3).pluck(:drug_type_id2).uniq

    @hot_type_name = DrugType.where(id: drug_type_id2s).pluck(:name)

    @type_drugs = []

    drug_type_id2s.each do |drug_type_id2|
      drugs = @store.e_drugs.where(drug_type_id2: drug_type_id2).order("sales desc").limit(12)

      @type_drugs << drugs
    end

  end

  def incident
    @incident = Incident.find(params[:id])
  end

  def get_more_feedback
    @feedbacks = @store.feedbacks.order("created_at desc").page(params[:page]).per(5)

    respond_to do |format|
      format.json{
        render json: {
          data: @feedbacks, 
          current_page: @feedbacks.current_page,
          last_page: @feedbacks.last_page?,
          next_page: @feedbacks.next_page
        }.to_json
      }
      
    end
  end

  private
    def feedback_params
      params.require(:feedback).permit(:content)
    end

    def set_store
      store_name = params[:store_name]
      @store = EDrugstore.where(name: store_name).first
    end

end
