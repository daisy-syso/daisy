class DrugsDrugstoresController < ApplicationController
  before_action :check_auth
  before_action :set_drugstore, only: [:show, :edit, :update]

  respond_to :html

  def index
    @drugstores = @current_editor.drugstores.all.page(params[:page]).per(params[:per])
  end

  def show
  end

  def new
    @drugstore = Drugs::Drugstore.new
  end

  def edit
    
  end

  def create
    @drugstore = @current_editor.drugstores.new(drugstore_params)
    if @drugstore.save
      flash[:notice] = '药店创建成功.' 
    end

    redirect_to drugs_drugstores_path
  end

  def update
    flash[:notice] = '药店更新成功.' if @drugstore.update(drugstore_params)

    respond_with(@drugstore)
  end

  def destroy
    @drugstore.destroy

    flash[:notice] = '药店下架成功.' 

    redirect_to drugs_drugstore_path
  end

  private
    def set_drugstore
      @drugstore = Drugs::Drugstore.find(params[:id])
    end

    def drugstore_params
      params.require(:drugs_drugstore).permit(:name, :address, :telephone, :image_url, :county_id, :city_id)
    end
end