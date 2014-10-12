class EldercaresAPI < ApplicationAPI

  Types = {
    :"eldercares/nursing_rooms" => "养老院",
    :"eldercares/social_security_endowments" => "养老保险",
    :"eldercares/insurances" => "养老保险（商业）",
  }

  namespace :eldercares do

    namespace :nursing_rooms do
      index! Eldercares::NursingRoom,
        title: "养老服务 养老院",
        filters: { 
          city: city_filters,
          type: type_filters(Types),
          zone: fake_zone_filters,
          order_by: order_by_filters(Eldercares::NursingRoom)
        }

      show! Eldercares::NursingRoom
    end

    namespace :social_security_endowments do
      index! SocialSecurities::SocialSecurityEndowment,
        title: "养老服务 养老保险",
        includes: [:city, :province],
        with: SocialSecurities::SocialSecurityEndowmentEntity,
        filters: { 
          type: type_filters(Types, :"eldercares/social_security_endowments"),
          province: { class: Categories::Province, title: "位置", titleize: true },
          zone: fake_zone_filters,
          order_by: order_by_filters(SocialSecurities::SocialSecurityEndowment)
        }
    end

    namespace :insurances do
      index! Insurances::Insurance,
        title: "养老服务 养老保险（商业）",
        filters: { 
          type: type_filters(Types, :"eldercares/insurances"),
          insurance_type: { default: 8435, class: Insurances::InsuranceType, scope_only: true },
          zone: fake_zone_filters,
          order_by: order_by_filters(Insurances::Insurance)
        }
    end

  end
end
