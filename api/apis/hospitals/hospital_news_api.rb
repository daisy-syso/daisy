class Hospitals::HospitalNewsAPI < ApplicationAPI

  namespace :hospital_news do
    index! Hospitals::HospitalNews,
      title: "诊疗攻略",
      filters: { 
        city: fake_city_filters,
        type: type_filters(:examination),
        hospital_type: { scope_only: true },
        county: fake_county_filters,
        order_by: order_by_filters(Hospitals::HospitalNews),
        form: form_filters
      }
      
    show! Hospitals::HospitalNews

  end
end
