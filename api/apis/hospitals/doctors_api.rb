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
          disease: { title: proc { Diseases::Disease.find_by_id(params[:disease]).try(:name) || "疾病"}, class: Diseases::Disease },
          hospital_room: { title: proc { Hospitals::HospitalRoom.find_by_id(params[:hospital_room]).try(:name) || "科室"}, class: Hospitals::HospitalRoom },
          alphabet: alphabet_filters
        }),
        order_by: order_by_filters(Hospitals::Doctor),
        form: form_filters,
        need_order: form_switch_filters("无需预约"),
        has_return: form_switch_filters("返现"),
        # query: form_query_filters, 
        # position_query: form_query_filters("职称"), 
        # hospital_query: form_query_filters("所属医院"),
        template: form_radio_array_filters_new("doctor", "当前主题精选")
      }

    show! Hospitals::Doctor
  end
end
