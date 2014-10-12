class Hospitals::SpecialistsAPI < ApplicationAPI

  namespace :specialists do
    index! Hospitals::Hospital,
      title: "热门专科",
      parent: proc { Hospitals::Hospital.specialist },
      filters: { 
        city: city_filters,
        hospital_type: {
          class: Hospitals::HospitalType,
          title: "类别", 
          children: proc { Hospitals::HospitalType.specialist_filters }
        },
        zone: fake_zone_filters,
        order_by: order_by_filters(Hospitals::Hospital)
      }
  end
end
