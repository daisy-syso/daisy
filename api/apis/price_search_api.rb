class PriceSearchAPI < ApplicationAPI

  namespace :price_search do

    namespace :drugs do
      index! Drugs::Drug,
        title: "价格搜索 药品",
        filters: { 
          type: type_filters,
          disease: { class: Diseases::Disease, scope_only: true },
          county: fake_county_filters,
          order_by: order_by_filters(Drugs::Drug),
          form: form_filters,
          query: form_query_filters, 
          price: form_price_filters,
          manufactory_query: form_radio_array_filters(
            %w(三精制药 同仁堂 修正药业 太极集团), "品牌"),
          alphabet: form_alphabet_filters
        }
    end

    namespace :shaping_items do
      index! Shapings::ShapingItem,
        title: "价格搜索 整形",
        filters: {
          type: type_filters,
          shaping_type: { class: Shapings::ShapingType, scope_only: true },
          county: fake_county_filters,
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
          type: type_filters,
          hospital_type: { class: Hospitals::HospitalType, scope_only: true },
          county: fake_county_filters,
          order_by: hospital_order_by_filters,
          form: form_filters,
          query: form_query_filters, 
          alphabet: form_alphabet_filters,
          hospital_level: form_radio_filters(Hospitals::HospitalLevel, "医院等级"),
          has_url: form_switch_filters("网址"),
          is_local_hot: form_switch_filters("热门医院")
        }
    end

    namespace :confinement_centers do
      index! Maternals::ConfinementCenter,
        title: "价格搜索 月子中心",
        filters: { 
          city: city_filters,
          type: type_filters,
          county: fake_county_filters,
          order_by: order_by_filters(Maternals::ConfinementCenter),
          form: form_filters,
          query: form_query_filters, 
          alphabet: form_alphabet_filters,
          has_url: form_switch_filters("网址")
        }
    end

    namespace :maternal_halls do
      index! Maternals::MaternalHall,
        title: "价格搜索 母婴会馆",
        filters: { 
          city: city_filters,
          type: type_filters,
          county: fake_county_filters,
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
          type: type_filters,
          insurance_type: { class: Insurances::InsuranceType, scope_only: true },
          county: fake_county_filters,
          order_by: order_by_filters(Insurances::Insurance),
          form: form_filters,
          query: form_query_filters, 
          alphabet: form_alphabet_filters
        }
    end

  end
end
