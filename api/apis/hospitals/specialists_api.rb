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
        order_by: order_by_filters(Hospitals::Hospital),
        form: form_filters,
        query: form_query_filters, 
        alphabet: form_alphabet_filters,
        hospital_level: form_radio_filters(Hospitals::HospitalLevel, 
          "医院等级", :hospital_level),
        has_url: form_switch_filters("网址", :has_url),
        is_local_hot: form_switch_filters("热门医院", :is_local_hot)
      }
  end
end
