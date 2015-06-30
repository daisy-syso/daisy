class Drugs::DrugsAPI < ApplicationAPI
  # require 'grape/rabl'
  format :json
  # formatter :json, Grape::Formatter::Rabl

  namespace :drugs do 
    index! Drugs::Drug,
      title: "药品大全",
      filters: { 
        city: fake_city_filters,
        type: type_filters("药品大全", :drug),
        search_by: search_by_filters({
          default: :disease,
          disease: { title: proc { Drugs::DrugType.where(id: params[:disease]).first.try(:name) || "疾病"}, class: Drugs::DrugType },
          hospital_room: { title: "科室", class: Hospitals::HospitalRoom },
          alphabet: alphabet_filters,
          manufactory: {title: "品牌", class: Drugs::Manufactory }
        }),
        order_by: order_by_filters(Drugs::Drug),
        form: form_filters,
        query: form_query_filters, 
        price: form_price_filters,
        manufactory_query: form_radio_array_filters(
          %w(三精制药 同仁堂 修正药业 太极集团), "品牌"),
        alphabet: form_alphabet_filters
      }

    # show! Drugs::Drug

    # params do 
    #   requires :id, type: Integer, desc: 'ID'
    # end
    # get '/:id' do
    #   @drug = Drugs::Drug.find(2728)
    #   # @drug_detaills = Drugs::DrugDetail.where(parent_id: @drug.id)
    # end

    # 第一层
    params do
      optional :page, type: Integer, desc: 'page'
      optional :per_page, type: Integer, desc: 'per_page'
    end
    get '/' do
      @drug = Drugs::Drug.all.page(page).per(per_page)
    end
    
    # 第二层
    params do
      requires :drug_name, type: String, desc: 'Name'
      optional :page, type: Integer, desc: 'page'
      optional :per_page, type: Integer, desc: 'per_page'
    end
    get '/:id/manufactory' do
      @drugs = Drugs::Drug.where(name: params[:drug_name]).page(page).per(per_page)
      present :drug, @drugs, with: Drugs::ManufactoryEntity
    end

    # 第三层
    params do
      requires :id, type: Integer, desc: 'ID'
    end
    get '/:id' do
      @drug = Drugs::Drug.find(params[:id])
      present :drug, @drug, with: Drugs::DrugEntity
      @drug_detaills = Drugs::DrugDetail.where(parent_id: @drug.id)
      present :drug_details, @drug_detaills, with: Drugs::DrugdetailEntity
    end

  end
end
