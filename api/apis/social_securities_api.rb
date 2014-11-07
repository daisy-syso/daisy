class SocialSecuritiesAPI < ApplicationAPI

  namespace :social_securities do

    namespace :social_securities do
      index! SocialSecurities::SocialSecurity, 
        title: "医保查询",
        includes: :city,
        with: SocialSecurities::SocialSecurityEntity,
        filters: { 
          type: type_filters(6000),
          city: city_filters,
          county: fake_county_filters,
          order_by: order_by_filters(SocialSecurities::SocialSecurity),
          form: form_filters
        }
    end

    namespace :social_security_hospitals do
      index! SocialSecurities::SocialSecurityHospital, 
        title: "医保查询 医院",
        includes: :city,
        with: SocialSecurities::SocialSecurityEntity,
        filters: { 
          type: type_filters,
          city: city_filters,
          county: fake_county_filters,
          order_by: order_by_filters(SocialSecurities::SocialSecurityHospital),
          form: form_filters
        }
    end

    namespace :social_security_drugstores do
      index! SocialSecurities::SocialSecurityDrugstore, 
        title: "医保查询 药店",
        includes: :city,
        with: SocialSecurities::SocialSecurityEntity,
        filters: { 
          type: type_filters,
          city: city_filters,
          county: fake_county_filters,
          order_by: order_by_filters(SocialSecurities::SocialSecurityDrugstore),
          form: form_filters
        }
    end

    namespace :social_security_drugs do
      index! SocialSecurities::SocialSecurityDrug, 
        title: "医保查询 药品",
        includes: :city,
        with: SocialSecurities::SocialSecurityEntity,
        filters: { 
          type: type_filters,
          city: city_filters,
          county: fake_county_filters,
          order_by: order_by_filters(SocialSecurities::SocialSecurityDrug),
          form: form_filters
        }
    end

    namespace :social_security_endowments do
      index! SocialSecurities::SocialSecurityEndowment,
        title: "医保查询",
        includes: [:city, :province],
        with: SocialSecurities::SocialSecurityEndowmentEntity,
        filters: { 
          type: type_filters,
          city: city_filters,
          county: fake_county_filters,
          order_by: order_by_filters(SocialSecurities::SocialSecurityEndowment),
          form: form_filters
        }
    end
    
  end
end
