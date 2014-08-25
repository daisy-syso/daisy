module Hospitals
  class HospitalsAPI < Grape::API
    extend ResourcesHelper

    get "hospital/:id" do
      hospital = Hospitals::Hospital.find params[:id]
      present! hospital, detail: true
      hospital.click!
    end

    resources :hospitals, 
      class: Hospitals::Hospital,
      title: "医院大全",
      filters: { 
        city: { default: 1, class: City, title: "位置" },
        hospital_type: { class: Hospitals::HospitalType, title: "医院类型" }
      }
      
  end
end