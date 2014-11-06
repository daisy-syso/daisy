class CouponsAPI < ApplicationAPI

  namespace :coupons do

    namespace :coupons do
      index! Coupons::Coupon,
        title: "热门精选",
        filters: { 
          type: type_filters,
          county: fake_county_filters,
          order_by: order_by_filters(Coupons::Coupon)
        }
    end

  end
end
