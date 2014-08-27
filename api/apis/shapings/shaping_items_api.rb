module Shapings
  class ShapingItemsAPI < Grape::API
    extend ResourcesHelper
    extend FilterHelper

    namespace :price_search do
      index! :shaping_items, 
        class: Shapings::ShapingItem,
        title: "价格搜索 整形",
        filters: { 
          shaping_type: { class: Shapings::ShapingType, title: "整形类别" },
          price: { 
            title: "价格区间", 
            type: Hash,
            using: [:from, :to],
            children: proc {
              generate_price_filters Setting.get("price_search.shaping_items.filters.price", 
                [0, 100, 200, 500])
            }, 
            current: proc { |price| 
              price ? "#{price[:from]} ~ #{price[:to]} 元" : "全部"
            }
          }
        }
    end

  end
end