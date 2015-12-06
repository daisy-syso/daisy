class Stores::StoresController < StoresController
  before_action :set_store

  def index
    @feedbacks = @store.feedbacks.order("created_at desc").page(1).per(5)

    @incidents = @store.incidents
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
