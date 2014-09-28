class CouponsAPI < ApplicationAPI

  Types = {
    :"coupons/coupons" => "主编推荐",
    :"coupons/drugs" => { class: Diseases::Disease, title: "药品", id: :disease },
  }

  namespace :coupons do

    namespace :drugs do
      index! Drugs::Drug,
        title: "返利优惠 药品",
        filters: { 
          type: type_filters(Types, :"coupons/drugs"),
          disease: { class: Diseases::Disease, scope_only: true },
          price: price_filters,
          order_by: price_search_order_by_filters(Drugs::Drug)
        }
    end

    namespace :coupons do
      index! Coupons::Coupon,
        title: "返利优惠 主编推荐",
        filters: { 
          type: type_filters(Types, :"coupons/coupons"),
          order_by: order_by_filters(Coupons::Coupon)
        }
    end

  end
end
