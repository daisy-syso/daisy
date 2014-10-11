class Hospitals::HospitalsAPI < ApplicationAPI

  namespace :hospitals do
    index! Hospitals::Hospital,
      title: "医院大全",
      filters: { 
        city: city_filters,
        hospital_type: { class: Hospitals::HospitalType, title: "类别" },
        zone: fake_zone_filters,
        order_by: hospital_order_by_filters
      }

    get ":id" do
      hospital = Hospitals::Hospital.find params[:id]
      present! hospital, detail: true
      hospital.click!
    end
  end
end
