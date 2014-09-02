class Hospitals::TopSpecialistsAPI < Grape::API
  extend ResourcesHelper

  namespace :top_specialists do
    index! Hospitals::Hospital,
      title: "热门专科",
      scopes: :top_specialists,
      filters: { 
        city: { default: 1, class: Categories::City, title: "位置" },
        hospital_type: {
          class: Hospitals::HospitalType,
          title: "专科类型", 
          children: proc {
            Hospitals::HospitalType.top_specialists_filters
          }
        }
      }
  end
end
