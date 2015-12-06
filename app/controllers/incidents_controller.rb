class IncidentsController < ApplicationController
  before_action :check_auth
  before_action :set_incident, only: [:show, :edit, :update, :destroy]
  
  before_action :set_drugstore, only: [:index, :new, :create, :show, :edit, :update, :destroy]

  before_action :is_own?, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def is_own?
    if @current_editor.role != 'admin' && @current_editor.id != @drugstore.editor_id
      flash[:notice] = '您不能访问那页面.' 
      redirect_to drugs_drugs_path
    end
  end

  def index
    @incidents = @drugstore.incidents.all.page(params[:page]).per(params[:per])
  end

  def show
  end

  def new
    @incident = @drugstore.incidents.new
  end

  def edit
    
  end

  def create
    @incident = @drugstore.incidents.new(incident_params)

    if @incident.save
      flash[:notice] = '动态创建成功.' 
    end

    redirect_to e_drugstore_incident_path(@drugstore, @incident)
  end

  def update
    flash[:notice] = '动态更新成功.' if @incident.update(incident_params)

    redirect_to e_drugstore_incident_path(@drugstore, @incident)
  end

  def destroy
    @incident.destroy
    flash[:notice] = '动态成功.' 
    redirect_to e_drugstore_incidents_path(@drugstore.id)
  end

  private
    def set_incident
      @incident = Incident.find(params[:id])
    end

    def incident_params
      params.require(:incident).permit(:title, :content, :image_url, :author)
    end

    def set_drugstore
      @drugstore = EDrugstore.find(params[:e_drugstore_id])
    end
end