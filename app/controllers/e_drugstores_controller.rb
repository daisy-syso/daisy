class EDrugstoresController < ApplicationController
  before_action :check_auth
  before_action :set_drugstore, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @drugstores = @current_editor.e_drugstores.all.page(params[:page]).per(params[:per])
  end

  def show
  end

  def new
    @drugstore = EDrugstore.new
  end

  def edit
    
  end

  def create
    @drugstore = EDrugstore.new(drugstore_params)
    @drugstore.editor_id = @current_editor.id

    if @drugstore.save
      flash[:notice] = '药店创建成功.' 
    end

    redirect_to e_drugstores_path
  end

  def update
    flash[:notice] = '药店更新成功.' if @drugstore.update(drugstore_params)

    respond_with(@drugstore)
  end

  def destroy
    @drugstore.destroy

    flash[:notice] = '药店删除成功.' 

    redirect_to e_drugstores_path
  end

  private
    def set_drugstore
      @drugstore = EDrugstore.find(params[:id])
    end

    def drugstore_params
      params.require(:e_drugstore).permit(:name, :address, :telephone, :image_url, :county_id, :city_id, :lng, :lat, :business_license, :description, :website)
    end
end