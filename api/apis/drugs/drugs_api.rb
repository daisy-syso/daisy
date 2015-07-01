class Drugs::DrugsAPI < ApplicationAPI
  # require 'grape/rabl'
  format :json
  # formatter :json, Grape::Formatter::Rabl

  namespace :drugs do 
    # index! Drugs::Drug,
    #   title: "药品大全",
    #   filters: { 
    #     city: fake_city_filters,
    #     type: type_filters("药品大全", :drug),
    #     search_by: search_by_filters({
    #       default: :disease,
    #       disease: { title: proc { Drugs::DrugType.where(id: params[:disease]).first.try(:name) || "疾病"}, class: Drugs::DrugType },
    #       hospital_room: { title: "科室", class: Hospitals::HospitalRoom },
    #       alphabet: alphabet_filters,
    #       manufactory: {title: "品牌", class: Drugs::Manufactory }
    #     }),
    #     order_by: order_by_filters(Drugs::Drug),
    #     form: form_filters,
    #     query: form_query_filters, 
    #     price: form_price_filters,
    #     manufactory_query: form_radio_array_filters(
    #       %w(三精制药 同仁堂 修正药业 太极集团), "品牌"),
    #     alphabet: form_alphabet_filters
    #   }

    # show! Drugs::Drug

    # params do 
    #   requires :id, type: Integer, desc: 'ID'
    # end
    # get '/:id' do
    #   @drug = Drugs::Drug.find(2728)
    #   # @drug_detaills = Drugs::DrugDet3ail.where(parent_id: @drug.id)
    # end

    # 第一层
    params do
      optional :page, type: Integer, desc: 'page'
      optional :per_page, type: Integer, desc: 'per_page'
    end
    get '/' do
      drugs_counts = Drugs::Drug.search({query:{match_all:{}},facets: {drugs_count: {terms: {field: "name", size: 10000000}}}}).response.facets['drugs_count']['terms']

      drugs_counts.sort_by!{|u| u.term}

      count = []
      drugs_counts.each do |drug|
        tmp = {
          name: drug['term'],
          count: drug['count']
        }
        count << tmp
      end

      page = params[:page] || 0
      per_page = params[:per_page] || 25

      offset = page * per_page
      
      result_c = count[offset, per_page]

      dds = []
      result_c.each do |result|
        dd = Drugs::Drug.where(name: result[:name]).first
        tmp = {
          name: dd.name,
          image_url: dd.image_url,
          count: result[:count]
        }
        dds << tmp
      end

      present :drugs, dds
    end
    
    # 第二层
    params do
      requires :drug_name, type: String, desc: 'Name'
      optional :page, type: Integer, desc: 'page'
      optional :per_page, type: Integer, desc: 'per_page'
    end
    get '/:drug_name/manufactories' do
      @drugs = Drugs::Drug.where(name: params[:drug_name]).page(params[:page]).per(params[:per_page])

      drug_manufactory = []

      @drugs.each do |drug|
        # debugger
        dmfs = Drugs::DrugManufactoryStore.where(drug_id: drug.id)
        manufactory_ids = dmfs.map(&:manufactory_id)

        dm = Drugs::Manufactory.where(id: manufactory_ids)

        manufactories = []
        dm.each_with_index do |s, index|
          tmp_manu = {
            id: s.id,
            name: s.name,
            address: s.registered_address,
            telephone: s.tel,
            url: s.url,
            production_classification: s.production_classification
          }
          manufactories << tmp_manu
        end

        tmp = {
          id: drug.id,
          name: drug.name,
          image_url: drug.image_url,
          manufactory: drug.manufactory,
          spec: drug.spec,
          manufactories: manufactories
        }

        drug_manufactory << tmp
      end

      present :drugs, drug_manufactory
    end

    # 第三层
    params do
      requires :id, type: Integer, desc: 'ID'
      requires :manufactory_id, type: Integer, desc: 'ID'
    end
    get '/:id/:manufactory_id' do
      @drug = Drugs::Drug.find(params[:id])
      dmfss = Drugs::DrugManufactoryStore.where(drug_id: @drug.id, manufactory_id: params[:manufactory_id])

      dmfss_prices = dmfss.map(&:price)
      stores = []
      dmfss.each_with_index do |dmfs, index|
        store = Drugs::Drugstore.find(dmfs.drugstore_id)
        tmp = {
          name: store.name,
          address: store.address,
          telephone: store.telephone,
          image_url: store.image_url,
          star: store.star,
          reviews_count: store.reviews_count,
          price: dmfss_prices[index]
        }
        stores << tmp
      end

      present :drug, @drug, with: Drugs::DrugEntity

      @drug_detaills = Drugs::DrugDetail.where(parent_id: @drug.id)

      present :drug_details, @drug_detaills, with: Drugs::DrugdetailEntity

      present :stores, stores
    end

  end
end
