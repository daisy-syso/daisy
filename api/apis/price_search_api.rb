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
  }

  namespace :price_search do

    namespace :drugs do
      index! Drugs::Drug,
        title: "价格搜索 药品",
        filters: { 
          type: type_filters(Types, :"price_search/drugs"),
          disease: {class: Diseases::Disease, scope_only: true },
          price: price_filters,
          zone: zone_filters,
          order_by: price_search_order_by_filters(Drugs::Drug)
        }
    end

    namespace :shaping_items do
      index! Shapings::ShapingItem,
        title: "价格搜索 整形",
        filters: {
          type: type_filters(Types, :"price_search/shaping_items"),
          shaping_type: { class: Shapings::ShapingType, scope_only: true },
          price: price_filters,
          zone: zone_filters,
          order_by: price_search_order_by_filters(Shapings::ShapingItem)
        }
    end

    namespace :hospitals do
      index! Hospitals::Hospital,
        title: proc { "价格搜索 #{Hospitals::HospitalType.find(params[:hospital_type]).name}" },
        filters: {
          city: city_filters,
          type: type_filters(Types, :"price_search/hospitals"),
          hospital_type: { class: Hospitals::HospitalType, scope_only: true },
          zone: zone_filters,
          order_by: order_by_filters(Hospitals::Hospital)
        }
    end

  end
end
