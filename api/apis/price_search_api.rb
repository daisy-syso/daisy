class PriceSearchAPI < Grape::API
  extend ResourcesHelper
  extend FilterHelper

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
          price: { 
            title: "价格区间", 
            type: Hash,
            using: [:from, :to],
            children: proc {
              generate_price_filters Setting["price_search.shaping_items.filters.price"]
            }, 
            current: proc { |price| 
              price ? "#{price[:from]} ~ #{price[:to]} 元" : "全部"
            }
          }
        }
    end

    namespace :drugs do
      index! Drugs::Drug,
        title: "价格搜索 药品",
        filters: { 
          disease: { class: Diseases::Disease, title: "疾病类别" },
          price: { 
            title: "价格区间", 
            type: Hash,
            using: [:from, :to],
            children: proc {
              generate_price_filters Setting["price_search.drugs.filters.price"]
            }, 
            current: proc { |price| 
              price ? generate_price_title(price[:from], price[:to]) : "全部"
            }
          }
        }
    end
  end

end
