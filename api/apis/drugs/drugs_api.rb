class Drugs::DrugsAPI < ApplicationAPI

  format :json

  namespace :drugs do
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
        next if dd.blank?
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
      requires :name, type: String, desc: 'Name'
      optional :page, type: Integer, desc: 'page'
      optional :per_page, type: Integer, desc: 'per_page'
    end
    get '/drug_manufactories' do

      @drugs = Drugs::Drug.where(name: params[:name]).page(params[:page]).per(params[:per_page])

      drug_manufactories = []

      @drugs.each do |drug|

        dmfs = Drugs::DrugManufactoryStore.where(drug_id: drug.id)
        manufactory_ids = dmfs.map(&:manufactory_id)

        dm = Drugs::Manufactory.where(id: manufactory_ids)

        dm.each do |s|
          tmp_manu = {
            drug_id: drug.id,
            drug_name: drug.name,
            drug_image_url: drug.image_url,
            spec: drug.spec,
            manufactory_id: s.id,
            manufactory_name: s.name,
            manufactory_address: s.registered_address,
            manufactory_telephone: s.tel,
            manufactory_url: s.url,
            manufactory_production_classification: s.production_classification
          }
          drug_manufactories << tmp_manu
        end
      end

      present :drug_manufactories, drug_manufactories
    end

    # 第三层
    params do
      requires :drug_id, type: Integer, desc: '药品ID'
      requires :manufactory_id, type: Integer, desc: '药厂ID'
      optional :page, type: Integer, desc: 'page'
      optional :per_page, type: Integer, desc: 'per_page'
    end
    get '/:drug_id/:manufactory_id' do
      @drug = Drugs::Drug.find(params[:drug_id])
      dmfss = Drugs::DrugManufactoryStore.where(drug_id: @drug.id, manufactory_id: params[:manufactory_id]).page(params[:page]).per(params[:per_page])

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

      present :drug, @drug

      @drug_detaills = Drugs::DrugDetail.where(parent_id: @drug.id)

      present :drug_details, @drug_detaills, with: Drugs::DrugdetailEntity

      present :stores, stores
    end

  end
end
