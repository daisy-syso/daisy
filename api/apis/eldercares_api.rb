class EldercaresAPI < ApplicationAPI

  namespace :eldercares do

    namespace :nursing_rooms do
      index! Eldercares::NursingRoom,
        title: "养老公寓",
        filters: { 
          city: city_filters,
          type: type_filters(:eldercare),
          county: county_filters,
          order_by: order_by_filters(Eldercares::NursingRoom),
          form: form_filters,
          query: form_query_filters, 
          alphabet: form_alphabet_filters
        }

      show! Eldercares::NursingRoom
    end

    namespace :social_security_endowments do
      index! SocialSecurities::SocialSecurityEndowment,
        title: "养老保险（社保）",
        includes: [:city, :province],
        with: SocialSecurities::SocialSecurityEndowmentEntity,
        filters: { 
          type: type_filters,
          province: { class: Categories::Province, title: "位置", titleize: true },
          county: fake_county_filters,
          order_by: order_by_filters(SocialSecurities::SocialSecurityEndowment)
        }
    end

    namespace :insurances do
      index! Insurances::Insurance,
        title: "养老保险（商业）",
        filters: { 
          type: type_filters,
          insurance_type: { default: 8435, class: Insurances::InsuranceType, scope_only: true },
          county: fake_county_filters,
          order_by: order_by_filters(Insurances::Insurance),
          form: form_filters,
          # query: form_query_filters, 
          # alphabet: form_alphabet_filters
          need_order: form_switch_filters("无需预约"),
          has_return: form_switch_filters("返现"),
          template: form_radio_array_filters(%w(不限 团体寿险（消费型） 两全保险（红利返还） 万能险（满期返钱） 投资连结保险（保单贷款） 终身寿险（保费豁免） 定期寿险（可返钱） 分红险（年金转换）),
            "当前主题精选"),
          price_scope: form_price_scope_filters([1000, 5000, 10000, 50000, 100000])
        }
    end

  end
end
