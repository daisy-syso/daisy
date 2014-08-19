module Hospitals
  class HospitalAPI < Grape::API

    params do
      optional :city, type: Integer, default: 1, desc: "Filter by: City ID"
    end
    get :hospitals do
      has_scope :city

      current = City.find(params[:city]).name
      data = apply_scopes(Hospitals::Hospital.all)
      filters = [{ title: "位置", children: filter_cities_cached, current: current }]
      present! data, meta: { filters: filters, title: "医院大全" }
    end

  end

end