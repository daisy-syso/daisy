class Hospitals::HospitalsAPI < ApplicationAPI

  namespace :hospitals do
    index! Hospitals::Hospital,
      title: "医院大全",
      filters: { 
        city: { default: 1, class: Categories::City, title: "位置" },
        hospital_type: { class: Hospitals::HospitalType, title: "医院类型" },
        order_by: order_by_filters(Hospitals::Hospital)
      }

    get ":id" do
      hospital = Hospitals::Hospital.find params[:id]
      present! hospital, detail: true
      hospital.click!
    end
  end
end
