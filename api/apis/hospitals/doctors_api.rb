class Hospitals::DoctorsAPI < ApplicationAPI

  namespace :doctors do
    index! Hospitals::Doctor,
      title: "找医生",
      before: proc {
        if params[:hospital] && !Hospitals::Hospital.exists?(
          id: params[:hospital], city: params[:city])
          params.delete :hospital
        end
      },
      filters: {
        city: city_filters,
        # hospital: { 
        #   class: Hospitals::Hospital, 
        #   title: "医院",
        #   meta: { filterable: true },
        #   children: proc { Hospitals::Hospital.limit(100).filters(params[:city]) }
        # },
        hospital_room: { class: Hospitals::HospitalRoom, title: "类别" },
        zone: fake_zone_filters,
        order_by: order_by_filters(Hospitals::Doctor)
      }

    show! Hospitals::Doctor
  end
end
