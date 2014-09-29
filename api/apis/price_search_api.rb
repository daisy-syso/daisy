class PriceSearchAPI < ApplicationAPI

  Types = {
    :"price_search/drugs" => { class: Diseases::Disease, title: "药品", id: :disease },
    :"price_search/shaping_items" => { class: Shapings::ShapingType, title: "整形", id: :shaping_type },
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

  end
end
