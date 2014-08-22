module Hospitals
  class HospitalsAPI < Grape::API
    extend ResourcesHelper

    resources :hospitals, 
      class: Hospitals::Hospital,
      title: "医院大全",
      filters: { 
        city: { default: 1, class: City, title: "位置" },
        hospital_type: { class: Hospitals::HospitalType, title: "医院类型" }
      }
      
  end
end