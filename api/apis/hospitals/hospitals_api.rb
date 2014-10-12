class Hospitals::HospitalsAPI < ApplicationAPI

  namespace :hospitals do
    index! Hospitals::Hospital,
      title: "医院大全",
      filters: { 
        city: city_filters,
        hospital_type: { class: Hospitals::HospitalType, title: "类别" },
        zone: fake_zone_filters,
        order_by: hospital_order_by_filters,
        form: form_filters,
        hospital_level: form_radio_filters(Hospitals::HospitalLevel, 
          "医院等级", :hospital_level),
        query: form_query_filters, 
        alphabet: form_alphabet_filters,
        has_url: form_switch_filters("网址", :has_url),
        is_local_hot: form_switch_filters("热门医院", :is_local_hot)
      }

    get ":id" do
      hospital = Hospitals::Hospital.find params[:id]
      present! hospital, detail: true
      hospital.click!
    end
  end
end
