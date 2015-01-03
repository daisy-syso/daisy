class Hospitals::HospitalChargesAPI < ApplicationAPI

  namespace :polyclinic_treatments do
    index! Diseases::Disease, 
      title: "诊疗攻略",
      with: Hospitals::PolyclinicTreatmentEntity,
      filters: { 
        type: type_filters,
        city: fake_city_filters,
        county: fake_county_filters,
        order_by: order_by_filters(Diseases::Disease),
        form: form_filters
      }

    show! Diseases::Disease
  end

  namespace :polyclinic_charges do
    index! Hospitals::PolyclinicCharge, 
      title: "价格攻略",
      filters: { 
        type: type_filters,
        city: city_filters,
        province: { scope_only: true },
        county: fake_county_filters,
        order_by: order_by_filters(Hospitals::PolyclinicCharge),
        form: form_filters
      }
  end 

  namespace :hospital_charges do
    params do
      requires :hospital_parent_type, type: Integer
    end
    # p params[:hospital_parent_type]
    index! Hospitals::HospitalCharge, 
      meta: { nolink: true },
      # parent: proc { Hospitals::HospitalCharge.where(hospital_type_id: params[:type])},
      title: "价格攻略",
      filters: { 
        type: type_filters,
        hospital_parent_type: { scope_only: true },
        hospital_type: { scope_only: true },
        county: hospital_charge_type,
        order_by: order_by_filters(Hospitals::HospitalCharge),
        form: form_filters
      }
  end
end