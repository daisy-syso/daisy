class NetInfos::HospitalTypeNewsAPI < ApplicationAPI

  namespace :hospital_type_news do
    index! NetInfos::HospitalTypeNews,
      title: "诊疗攻略",
      filters: { 
        city: fake_city_filters,
        type: type_filters(:examination),
        hospital_type: { scope_only: true },
        county: fake_county_filters,
        order_by: order_by_filters(NetInfos::HospitalTypeNews),
        form: form_filters
      }
      
    show! NetInfos::HospitalTypeNews

  end
end
