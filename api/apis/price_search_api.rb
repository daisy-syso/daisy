class PriceSearchAPI < ApplicationAPI

  namespace :price_search do

    get do
      menu = {
        title: "价格搜索",
        data: [{
          title: "药品",
          link: "#/list/price_search/drugs",
        }, {
          title: "整容",
          link: "#/list/price_search/shaping_items",
        }]
      }
      present menu
    end

    namespace :shaping_items do
      index! Shapings::ShapingItem,
        title: "价格搜索 整形",
        filters: { 
          shaping_type: { class: Shapings::ShapingType, title: "整形类别" },
          price: price_filters(Shapings::ShapingItem),
          order_by: order_by_filters(Shapings::ShapingItem)
        }
    end

    namespace :drugs do
      index! Drugs::Drug,
        title: "价格搜索 药品",
        filters: { 
          disease: { class: Diseases::Disease, title: "疾病类别" },
          price: price_filters(Drugs::Drug),
          order_by: order_by_filters(Drugs::Drug)
        }
    end
  end

end
