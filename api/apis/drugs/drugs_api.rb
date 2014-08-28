module Drugs
  class DrugsAPI < Grape::API
    extend ResourcesHelper
    extend FilterHelper

    index! :drugs, 
      class: Drugs::Drug,
      title: "药品大全",
      filters: { 
        drug_type: { class: Drugs::DrugType, title: "药品类别" },
      }

    show! :drug,
      class: Drugs::Drug

    namespace :price_search do
      index! :drugs, 
        class: Drugs::Drug,
        title: "价格搜索 药品",
        filters: { 
          disease: { class: Drugs::Disease, title: "疾病类别" },
          price: { 
            title: "价格区间", 
            type: Hash,
            using: [:from, :to],
            children: proc {
              generate_price_filters Setting.get("price_search.drugs.filters.price", 
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