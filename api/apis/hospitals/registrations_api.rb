class Hospitals::RegistrationsAPI < ApplicationAPI

  namespace :registrations do
    index! Hospitals::Hospital,
      # with: Hospitals::RegistrationEntity,
      title: "手机挂号",
      filters: { 
        city: city_filters,
        hospital_type: { class: Hospitals::HospitalType, title: "类别" },
        zone: fake_zone_filters,
        order_by: hospital_order_by_filters
      }
  end
end
