class Hospitals::RegistrationsAPI < ApplicationAPI

  namespace :registrations do
    index! Hospitals::Hospital,
      # with: Hospitals::RegistrationEntity,
      title: "手机挂号",
      filters: { 
        city: city_filters,
        type: type_filters(1000),
        hospital_type: { scope_only: true },
        county: county_filters,
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
end
