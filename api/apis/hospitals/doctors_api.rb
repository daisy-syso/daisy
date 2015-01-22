class Hospitals::DoctorsAPI < ApplicationAPI

  namespace :doctors do
    index! Hospitals::Doctor,
      title: "找医生",
      filters: {
        city: city_filters,
        type: type_filters("找医生", :doctor),
        search_by: search_by_filters({
          default: :disease,
          hospital: { title: "医院", class: Hospitals::Hospital },
          disease: { title: "疾病", class: Diseases::Disease },
          hospital_room: { title: "科室", class: Hospitals::HospitalRoom },
          alphabet: alphabet_filters
        }),
        order_by: order_by_filters(Hospitals::Doctor),
        form: form_filters,
        query: form_query_filters, 
        position_query: form_query_filters("职称"), 
        hospital_query: form_query_filters("所属医院")
      }

    show! Hospitals::Doctor
  end
end
