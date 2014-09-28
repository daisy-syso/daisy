class Hospitals::TopSpecialistsAPI < ApplicationAPI

  namespace :top_specialists do
    index! Hospitals::Hospital,
      title: "热门专科",
      parent: proc { Hospitals::Hospital.top_specialists },
      filters: { 
        city: city_filters,
        hospital_type: {
          class: Hospitals::HospitalType,
          title: "专科类型", 
          children: proc {
            Hospitals::HospitalType.top_specialists_filters
          }
        },
        order_by: order_by_filters(Hospitals::Hospital)
      }
  end
end
