class SocialSecuritiesAPI < ApplicationAPI

  namespace :social_securities do

    namespace :social_securities do
      index! SocialSecurities::SocialSecurity, 
        title: "医保查询",
        includes: :city,
        filters: { 
          type: type_filters(:social_security),
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
        filters: { 
          type: type_filters,
          city: city_filters,
          province: { scope_only: true },
          county: fake_county_filters,
          order_by: order_by_filters(SocialSecurities::SocialSecurityEndowment),
          form: form_filters
        }
    end
    
  end
end
