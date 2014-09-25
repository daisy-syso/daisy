class Hospitals::DoctorsAPI < ApplicationAPI

  namespace :doctors do
    index! Hospitals::Doctor,
      title: "找医生",
      filters: {
        city: city_filters.merge({
          has_scope: proc { |endpoint, collection, key|
            collection
          }  
        }),
        hospital: { 
          class: Hospitals::Hospital, 
          title: "医院",
          children: proc {
            Hospitals::Hospital.filters(params[:city])
          }
        },
        hospital_room: { class: Hospitals::HospitalRoom, title: "医院科室" },
        order_by: order_by_filters(Hospitals::Doctor)
      }

    show! Hospitals::Doctor
  end
end
