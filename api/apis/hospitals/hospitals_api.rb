module Hospitals
  class HospitalsAPI < Grape::API

    params do
      optional :city, type: Integer, default: 1
      optional :hospital_type, type: Integer
    end
    get :hospitals do
      has_scope :city
      has_scope :hospital_type

      city_current = City.find(params[:city]).name
      city_children = City.filters_with_cache

      hospital_type_current = params[:hospital_type] ?
        Hospitals::HospitalType.find(params[:hospital_type]).name : "全部"
      hospital_type_children = Hospitals::HospitalType.filters_with_cache

      filters = [{ title: "位置", children: city_children, current: city_current },
        { title: "医院类型", children: hospital_type_children, current: hospital_type_current }]
      data = apply_scopes!(Hospitals::Hospital.all)
      present! data, meta: { filters: filters, title: "医院大全" }
    end

    params do
      requires :id, type: Integer
    end
    get :"hospital/:id" do
      present! Hospitals::Hospital.find(params[:id])
    end

  end
end