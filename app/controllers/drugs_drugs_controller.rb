class DrugsDrugsController < ApplicationController
  before_action :check_auth
  before_action :set_drugs, only: [:show, :edit, :update, :destroy]
  before_action :is_own?, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def is_own?
    if @current_editor.role != 'admin' && @current_editor.id != @drug.editor_id
      flash[:notice] = '您不能访问那页面.' 
      redirect_to drugs_drugs_path
    end
  end

  def index
    @drugs = @current_editor.drugs.all.page(params[:page]).per(params[:per])
  end

  def show

  end

  def new
    @drug = Drugs::Drug.new
  end

  def edit
    
  end

  def create
    @drugs = @current_editor.drugs.new(drugs_params)
    if @drugs.save
      flash[:notice] = '药店创建成功.' 
    end

    redirect_to drugs_drugs_path
  end

  def update
    flash[:notice] = '药店更新成功.' if @drug.update(drugs_params)

    respond_with(@drug)
  end

  def destroy
    @drug.destroy
    flash[:notice] = '药品下架成功.' 
    redirect_to drugs_drugs_path
  end

  private
    def set_drugs
      @drug = Drugs::Drug.find(params[:id])
    end

    def drugs_params
      params.require(:drugs_drug).permit(:name, :manufactory, :ori_price, :price, :introduction, :image_url, :drug_type_id, :brand, :spec, :is_store)
    end
end