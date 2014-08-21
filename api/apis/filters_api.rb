class FiltersAPI < Grape::API

  namespace :filters do
    params do
      optional :city, type: Integer
    end
    get :"hospitals" do
      has_scope :city

      present! apply_scopes!(Hospitals::Hospital.all), 
        with: Hospitals::HospitalFilterEntity
    end
  end

end