class NetInfos::NetInfosAPI < ApplicationAPI

  namespace :polyclinic_treatments do
    index! Diseases::Disease, 
      title: "综合医院诊疗攻略",
      with: NetInfos::PolyclinicTreatmentEntity,
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
    index! NetInfos::PolyclinicCharge, 
      title: "综合医院价格攻略",
      filters: { 
        type: type_filters,
        city: city_filters,
        province: { scope_only: true },
        county: fake_county_filters,
        order_by: order_by_filters(NetInfos::PolyclinicCharge),
        form: form_filters
      }
  end
end