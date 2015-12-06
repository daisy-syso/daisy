class Stores::FeedbacksController < StoresController
  before_action :set_store
  def new
    @feedback = @store.feedbacks.new
  end

  def create
    @feedback = @store.feedbacks.new feedback_params
    @feedback.save

    if @feedback.save
      flash[:notice] = '发表成功.' 
    end

    redirect_to stores_root_path
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
