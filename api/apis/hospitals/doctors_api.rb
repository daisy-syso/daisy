module Hospitals
  class DoctorsAPI < Grape::API

    params do
      optional :hospital, type: Integer
      optional :hospital_room, type: Integer
    end
    get :doctors do
      has_scope :hospital
      has_scope :hospital_room

      hospital_current = params[:hospital] ?
        Hospitals::Hospital.find(params[:hospital]).name : "全部"
      hospital_children = Hospitals::Hospital.filters_with_cache

      hospital_room_current = params[:hospital_room] ?
        Hospitals::HospitalRoom.find(params[:hospital_room]).name : "全部"
      hospital_room_children = Hospitals::HospitalRoom.filters_with_cache

      filters = [{ title: "医院", children: hospital_children, current: hospital_current },
        { title: "医院科室", children: hospital_room_children, current: hospital_room_current }]
      data = apply_scopes!(Hospitals::Doctor.all)
      present! data, meta: { filters: filters, title: "找医生" }
    end

    params do
      requires :id, type: Integer
    end
    get :"doctor/:id" do
      present! Hospitals::Doctor.find(params[:id])
    end

  end
end