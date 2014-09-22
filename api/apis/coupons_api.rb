class CouponsAPI < Grape::API
  extend ResourcesHelper
  extend FilterHelper

  namespace :coupons do

    get do
      menu = {
        title: "返利优惠",
        data: [{
          title: "主编推荐",
          link: "#/list/coupons/coupons",
        }, {
          title: "药品",
          link: "#/list/coupons/drugs",
        }]
      }
      present menu
    end

    namespace :drugs do
      index! Drugs::Drug,
        title: "返利优惠 药品",
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


    namespace :coupons do
      get do
        present! apply_scopes!(Coupons::Coupon.includes(:item)).map(&:item), 
          with: PolymorphicEntity,
          meta: { title: "返利优惠 主编推荐" }
      end
    end
  end

end
