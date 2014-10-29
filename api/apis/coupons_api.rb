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
      title: "保险", 
      id: :insurance_type,
      children: proc do |children| 
        filters = append_url_to_filters Insurances::InsuranceType.price_search_filters, 
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
          type: type_filters(Types),
          county: fake_county_filters,
          order_by: order_by_filters(Coupons::Coupon)
        }
    end

    namespace :drugs do
      index! Drugs::Drug,
        title: "返利优惠 药品",
        filters: { 
          type: type_filters(Types),
          disease: { class: Diseases::Disease, scope_only: true },
          county: fake_county_filters,
          order_by: order_by_filters(Drugs::Drug),
          form: form_filters,
          query: form_query_filters, 
          price: form_price_filters,
          manufactory_query: form_radio_array_filters(
            %w(三精制药 同仁堂 修正药业 太极集团), "品牌", :manufactory_query),
          alphabet: form_alphabet_filters
        }
    end

    namespace :shaping_items do
      index! Shapings::ShapingItem,
        title: "返利优惠 整形",
        filters: {
          type: type_filters(Types),
          shaping_type: { class: Shapings::ShapingType, scope_only: true },
          price: price_filters,
          county: fake_county_filters,
          order_by: order_by_filters(Shapings::ShapingItem),
          form: form_filters,
          query: form_query_filters, 
          price: form_price_filters,
          alphabet: form_alphabet_filters
        }
    end

    namespace :hospitals do
      index! Hospitals::Hospital,
        title: proc { "返利优惠 #{Hospitals::HospitalType.find(params[:hospital_type]).name}" },
        filters: {
          city: city_filters,
          type: type_filters(Types),
          hospital_type: { class: Hospitals::HospitalType, scope_only: true },
          county: fake_county_filters,
          order_by: hospital_order_by_filters,
          form: form_filters,
          query: form_query_filters, 
          alphabet: form_alphabet_filters,
          hospital_level: form_radio_filters(Hospitals::HospitalLevel, 
            "医院等级", :hospital_level),
          has_url: form_switch_filters("网址", :has_url),
          is_local_hot: form_switch_filters("热门医院", :is_local_hot)
        }
    end

    namespace :confinement_centers do
      index! Maternals::ConfinementCenter,
        title: "返利优惠 月子中心",
        filters: { 
          city: city_filters,
          type: type_filters(Types),
          county: fake_county_filters,
          order_by: order_by_filters(Maternals::ConfinementCenter),
          form: form_filters,
          query: form_query_filters, 
          alphabet: form_alphabet_filters,
          has_url: form_switch_filters("网址", :has_url)
        }
    end

    namespace :maternal_halls do
      index! Maternals::MaternalHall,
        title: "返利优惠 母婴会馆",
        filters: { 
          city: city_filters,
          type: type_filters(Types),
          county: fake_county_filters,
          order_by: order_by_filters(Maternals::MaternalHall),
          form: form_filters,
          query: form_query_filters, 
          alphabet: form_alphabet_filters
        }
    end

    namespace :insurances do
      index! Insurances::Insurance,
        title: proc { "返利优惠 #{Insurances::InsuranceType.find(params[:insurance_type]).name}" },
        filters: { 
          type: type_filters(Types),
          insurance_type: { class: Insurances::InsuranceType, scope_only: true },
          county: fake_county_filters,
          order_by: order_by_filters(Insurances::Insurance),
          form: form_filters,
          query: form_query_filters, 
          alphabet: form_alphabet_filters
        }
    end

  end
end
