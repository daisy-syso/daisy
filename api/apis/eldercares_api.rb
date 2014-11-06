class EldercaresAPI < ApplicationAPI

  namespace :eldercares do

    namespace :nursing_rooms do
      index! Eldercares::NursingRoom,
        title: "养老公寓",
        filters: { 
          city: city_filters,
          type: type_filters(9000),
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
          query: form_query_filters, 
          alphabet: form_alphabet_filters
        }
    end

  end
end
