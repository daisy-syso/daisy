class CouponsAPI < ApplicationAPI

  Types = {
    :"coupons/coupons" => "主编推荐",
    :"coupons/drugs" => { class: Diseases::Disease, title: "药品", id: :disease },
    :"coupons/shaping_items" => { class: Shapings::ShapingType, title: "整形", id: :shaping_type },
    :"coupons/hospitals" => {
      class: Hospitals::HospitalType.price_search, 
      title: "专科", 
      id: :hospital_type,
      children: proc do |children| 
        filters = append_url_to_filters Hospitals::HospitalType.price_search_filters, 
          :"coupons/hospitals"
        children.concat filters
      end
    },
    :"coupons/confinement_centers" => "月子中心",
    :"coupons/maternal_halls" => "母婴会馆",
    :"coupons/insurances" => {
      class: Insurances::InsuranceType, 
      title: "专科", 
      id: :insurance_type,
      children: proc do |children| 
        filters = append_url_to_filters Insurances::InsuranceType.filters, 
          :"coupons/insurances"
        children.concat filters
      end
    }
  }

  namespace :coupons do

    namespace :coupons do
      index! Coupons::Coupon,
        title: "返利优惠 主编推荐",
        filters: { 
          type: type_filters(Types, :"coupons/coupons"),
          zone: fake_zone_filters,
          order_by: order_by_filters(Coupons::Coupon)
        }
    end

    namespace :drugs do
      index! Drugs::Drug,
        title: "返利优惠 药品",
        filters: { 
          type: type_filters(Types, :"coupons/drugs"),
          disease: { class: Diseases::Disease, scope_only: true },
          price: price_filters,
          zone: fake_zone_filters,
          order_by: price_search_order_by_filters(Drugs::Drug)
        }
    end

    namespace :shaping_items do
      index! Shapings::ShapingItem,
        title: "返利优惠 整形",
        filters: {
          type: type_filters(Types, :"coupons/shaping_items"),
          shaping_type: { class: Shapings::ShapingType, scope_only: true },
          price: price_filters,
          zone: fake_zone_filters,
          order_by: price_search_order_by_filters(Shapings::ShapingItem)
        }
    end

    namespace :hospitals do
      index! Hospitals::Hospital,
        title: proc { "返利优惠 #{Hospitals::HospitalType.find(params[:hospital_type]).name}" },
        filters: {
          city: city_filters,
          type: type_filters(Types, :"coupons/hospitals"),
          hospital_type: { class: Hospitals::HospitalType, scope_only: true },
          zone: fake_zone_filters,
          order_by: hospital_order_by_filters
        }
    end

    namespace :confinement_centers do
      index! Maternals::ConfinementCenter,
        title: "返利优惠 月子中心",
        filters: { 
          city: city_filters,
          type: type_filters(Types, :"coupons/confinement_centers"),
          zone: fake_zone_filters,
          order_by: order_by_filters(Maternals::ConfinementCenter)
        }
    end

    namespace :maternal_halls do
      index! Maternals::MaternalHall,
        title: "返利优惠 母婴会馆",
        filters: { 
          city: city_filters,
          type: type_filters(Types, :"coupons/maternal_halls"),
          zone: fake_zone_filters,
          order_by: order_by_filters(Maternals::MaternalHall)
        }
    end

    namespace :insurances do
      index! Insurances::Insurance,
        title: proc { "返利优惠 #{Insurances::InsuranceType.find(params[:insurance_type]).name}" },
        filters: { 
          type: type_filters(Types, :"coupons/insurances"),
          insurance_type: { class: Insurances::InsuranceType, scope_only: true },
          zone: fake_zone_filters,
          order_by: order_by_filters(Insurances::Insurance)
        }
    end

  end
end
