class Hospitals::RegistrationsAPI < ApplicationAPI

  namespace :registrations do
    index! Hospitals::Hospital,
      with: Hospitals::RegistrationEntity,
      title: "手机挂号",
      filters: { 
        city: { default: 1, class: Categories::City, title: "位置" },
        hospital_type: { class: Hospitals::HospitalType, title: "医院类型" },
        order_by: order_by_filters(Hospitals::Hospital)
      }
  end
end
