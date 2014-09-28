class Hospitals::HospitalsAPI < ApplicationAPI

  namespace :hospitals do
    index! Hospitals::Hospital,
      title: "医院大全",
      filters: { 
        city: city_filters,
        hospital_type: { class: Hospitals::HospitalType, title: "医院类型" },
        order_by: hospital_order_by_filters,
        filter_by: form_filters("filter_by" ,"筛选")
      }

    get ":id" do
      hospital = Hospitals::Hospital.find params[:id]
      present! hospital, detail: true
      hospital.click!
    end
  end
end
