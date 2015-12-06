class FeedbacksController < ApplicationController
  before_action :check_auth
  before_action :set_drugstore, only: [:index]
  before_action :is_own?, only: [:index]

  respond_to :html

  def is_own?
    if @current_editor.role != 'admin' && @current_editor.id != @drugstore.editor_id
      flash[:notice] = '您不能访问那页面.' 
      redirect_to drugs_drugs_path
    end
  end

  def index
    @feedbacks = @drugstore.feedbacks.all.page(params[:page]).per(params[:per])
  end

  private
    def set_drugstore
      @drugstore = EDrugstore.find(params[:e_drugstore_id])
    end
end