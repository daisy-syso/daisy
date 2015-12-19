class EDrugsController < ApplicationController
  before_action :check_auth
  before_action :set_drugs, only: [:show, :edit, :update, :destroy]
  before_action :is_own?, only: [:show, :edit, :update, :destroy]

  before_action :set_drugstore, only: [:index, :new, :create, :show, :edit, :update, :destroy]

  respond_to :html

  def is_own?
    if @current_editor.role != 'admin' && @current_editor.id != @drug.editor_id
      flash[:notice] = '您不能访问那页面.' 
      redirect_to drugs_drugs_path
    end
  end

  def get_types
    options = ""
    drug_type = DrugType.where(parent_id: params[:parent_id])
    drug_type.each do |s|
      options << "<option value=#{s.id}>#{s.name}</option>"
    end
    render :text => options
  end

  def index
    @drugs = @drugstore.e_drugs.all.page(params[:page]).per(params[:per])
  end

  def show
  end

  def new
    @drug = @drugstore.e_drugs.new
  end

  def edit
    @drug_type_id = @drug.drug_type_id
    @drug_type_id2 = @drug.drug_type_id2
    @drug_type_id3 = @drug.drug_type_id3
  end

  def create
    @drug = @drugstore.e_drugs.new(drugs_params)
    @drug.editor_id = @current_editor.id

    if @drug.save
      flash[:notice] = '药店创建成功.' 
    end

    redirect_to e_drugstore_e_drug_path(@drugstore, @drug)
  end

  def update
    flash[:notice] = '药店更新成功.' if @drug.update(drugs_params)

    redirect_to e_drugstore_e_drug_path(@drugstore, @drug)
  end

  def destroy
    @drug.destroy
    flash[:notice] = '药品下架成功.' 
    redirect_to e_drugstore_e_drugs_path(@drugstore.id)
  end

  private
    def set_drugs
      @drug = EDrug.find(params[:id])
    end

    def drugs_params
      params.require(:e_drug).permit(:name, :manufactory, :ori_price, :price, :introduction, :image_url, :brand, :code, :spec, :expiry_date, :drug_type_id, :drug_type_id2, :drug_type_id3, :sales)
    end

    def set_drugstore
      @drugstore = EDrugstore.find(params[:e_drugstore_id])
    end
end