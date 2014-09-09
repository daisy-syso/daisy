class Coupons::CouponsAPI < Grape::API
  extend ResourcesHelper

  namespace :coupons do

    get do
      present! apply_scopes!(Coupons::Coupon.includes(:item)).map(&:item), 
        with: PolymorphicEntity,
        meta: { title: "优惠返利" }
    end

  end
end
