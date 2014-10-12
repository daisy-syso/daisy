class PriceSearchAPI < ApplicationAPI

  Types = {
    :"price_search/drugs" => { class: Diseases::Disease, title: "药品", id: :disease },
    :"price_search/shaping_items" => { class: Shapings::ShapingType, title: "整形", id: :shaping_type },
    :"price_search/hospitals" => {
      class: Hospitals::HospitalType.price_search, 
      title: "专科", 
      id: :hospital_type,
      children: proc do |children| 
        filters = append_url_to_filters Hospitals::HospitalType.price_search_filters, 
          :"price_search/hospitals"
        children.concat filters
      end
    },
    :"price_search/confinement_centers" => "月子中心",
    :"price_search/maternal_halls" => "母婴会馆",
    :"price_search/insurances" => {
      class: Insurances::InsuranceType, 
      title: "保险", 
      id: :insurance_type,
      children: proc do |children| 
        filters = append_url_to_filters Insurances::InsuranceType.price_search_filters, 
          :"price_search/insurances"
        children.concat filters
      end
    }
  }

  namespace :price_search do

    namespace :drugs do
      index! Drugs::Drug,
        title: "价格搜索 药品",
        filters: { 
          type: type_filters(Types, :"price_search/drugs"),
          disease: { class: Diseases::Disease, scope_only: true },
          zone: fake_zone_filters,
          order_by: order_by_filters(Drugs::Drug),
          form: form_filters,
          query: form_query_filters, 
          price: form_price_filters,
          manufactory_query: form_radio_array_filters(
            %w(三精制药 同仁堂 修正药业 太极集团), "品牌", :manufactory_query),
          alphabet: form_alphabet_filters
        }
    end

    namespace :shaping_items do
      index! Shapings::ShapingItem,
        title: "价格搜索 整形",
        filters: {
          type: type_filters(Types, :"price_search/shaping_items"),
          shaping_type: { class: Shapings::ShapingType, scope_only: true },
          price: price_filters,
          zone: fake_zone_filters,
          order_by: order_by_filters(Shapings::ShapingItem),
          form: form_filters,
          query: form_query_filters, 
          price: form_price_filters,
          alphabet: form_alphabet_filters
        }
    end

    namespace :hospitals do
      index! Hospitals::Hospital,
        title: proc { "价格搜索 #{Hospitals::HospitalType.find(params[:hospital_type]).name}" },
        filters: {
          city: city_filters,
          type: type_filters(Types, :"price_search/hospitals"),
          hospital_type: { class: Hospitals::HospitalType, scope_only: true },
          zone: fake_zone_filters,
          order_by: hospital_order_by_filters,
          form: form_filters,
          query: form_query_filters, 
          alphabet: form_alphabet_filters,
          hospital_level: form_radio_filters(Hospitals::HospitalLevel, 
            "医院等级", :hospital_level),
          has_url: form_switch_filters("网址", :has_url),
          is_local_hot: form_switch_filters("热门医院", :is_local_hot)
        }
    end

    namespace :confinement_centers do
      index! Maternals::ConfinementCenter,
        title: "价格搜索 月子中心",
        filters: { 
          city: city_filters,
          type: type_filters(Types, :"price_search/confinement_centers"),
          zone: fake_zone_filters,
          order_by: order_by_filters(Maternals::ConfinementCenter),
          form: form_filters,
          query: form_query_filters, 
          alphabet: form_alphabet_filters,
          has_url: form_switch_filters("网址", :has_url)
        }
    end

    namespace :maternal_halls do
      index! Maternals::MaternalHall,
        title: "价格搜索 母婴会馆",
        filters: { 
          city: city_filters,
          type: type_filters(Types, :"price_search/maternal_halls"),
          zone: fake_zone_filters,
          order_by: order_by_filters(Maternals::MaternalHall),
          form: form_filters,
          query: form_query_filters, 
          alphabet: form_alphabet_filters
        }
    end

    namespace :insurances do
      index! Insurances::Insurance,
        title: proc { "价格搜索 #{Insurances::InsuranceType.find(params[:insurance_type]).name}" },
        filters: { 
          type: type_filters(Types, :"price_search/insurances"),
          insurance_type: { class: Insurances::InsuranceType, scope_only: true },
          zone: fake_zone_filters,
          order_by: order_by_filters(Insurances::Insurance),
          form: form_filters,
          query: form_query_filters, 
          alphabet: form_alphabet_filters
        }
    end

  end
end
