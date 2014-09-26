class PriceSearchAPI < ApplicationAPI

  Types = {
    :"price_search/drugs" => "药品",
    :"price_search/shaping_items" => "整形",
  }

  namespace :price_search do

    namespace :drugs do
      index! Drugs::Drug,
        title: "价格搜索 药品",
        filters: { 
          type: type_filters(Types, :"price_search/drugs"),
          disease: { class: Diseases::Disease, title: "疾病类别" },
          price: price_filters(Drugs::Drug),
          order_by: order_by_filters(Drugs::Drug)
        }
    end

    namespace :shaping_items do
      index! Shapings::ShapingItem,
        title: "价格搜索 整形",
        filters: {
          type: type_filters(Types, :"price_search/shaping_items"),
          shaping_type: { class: Shapings::ShapingType, title: "整形类别" },
          price: price_filters(Shapings::ShapingItem),
          order_by: order_by_filters(Shapings::ShapingItem)
        }
    end

  end
end
