module Hospitals
  class RegistrationsAPI < Grape::API
    extend ResourcesHelper

    namespace :registrations do
      index! Hospitals::Hospital,
        with: Hospitals::RegistrationEntity,
        title: "手机挂号",
        filters: { 
          city: { default: 1, class: City, title: "位置" },
          hospital_type: { class: Hospitals::HospitalType, title: "医院类型" }
        }
    end
      
  end
end