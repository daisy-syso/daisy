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
        order_by: order_by_filters(Hospitals::Doctor),
        form: form_filters,
        query: form_query_filters, 
        position_query: form_query_filters("职称", :position_query), 
        hospital_query: form_query_filters("所属医院", :hospital_query), 
        alphabet: form_alphabet_filters
      }

    show! Hospitals::Doctor
  end
end
