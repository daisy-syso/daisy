class Hospitals::HospitalTypesAPI < ApplicationAPI

  namespace :hospital_types do
    index! Hospitals::HospitalType, 
      title: "价格类别",
      # with: Hospitals::PolyclinicTreatmentEntity,
      parent: proc {Hospitals::HospitalType.where(parent_id: params[:hospital_parent_type])},
      filters: { 
        type: type_filters,
        city: fake_city_filters,
        county: fake_county_filters,
        order_by: order_by_filters(Hospitals::HospitalType),
        form: form_filters
      }

  end

end