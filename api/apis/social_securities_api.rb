class SocialSecuritiesAPI < ApplicationAPI

  Types = {
    :"social_securities/social_security_endowments" => "医保查询",
    :"social_securities/social_securities" => "医保指定机构",
    :"social_securities/social_security_hospitals" => "医保指定医院",
    :"social_securities/social_security_drugstores" => "医保指定药店",
    :"social_securities/social_security_drugs" => "医保指定药品",
  }

  class << self
    def index_options klass, title
      {
        title: title,
        includes: :city,
        with: SocialSecurities::SocialSecurityEntity,
        filters: { 
          type: type_filters(Types),
          province: { class: Categories::Province, title: "位置", titleize: true },
          county: fake_county_filters,
          order_by: order_by_filters(klass),
          form: form_filters
        },
        params: {
          per: { default: 15 }
        },
        meta: {
          per: 3
        }
      }
    end
  end

  namespace :social_securities do

    namespace :social_securities do
      index! SocialSecurities::SocialSecurity, 
        index_options(SocialSecurities::SocialSecurity, "医保查询 机构")
    end

    namespace :social_security_hospitals do
      index! SocialSecurities::SocialSecurityHospital, 
        index_options(SocialSecurities::SocialSecurityHospital, "医保查询 医院")
    end

    namespace :social_security_drugstores do
      index! SocialSecurities::SocialSecurityDrugstore, 
        index_options(SocialSecurities::SocialSecurityDrugstore, "医保查询 药店")
    end

    namespace :social_security_drugs do
      index! SocialSecurities::SocialSecurityDrug, 
        index_options(SocialSecurities::SocialSecurityDrug, "医保查询 药品")
    end

    namespace :social_security_endowments do
      index! SocialSecurities::SocialSecurityEndowment,
        title: "医保查询 养老",
        includes: [:city, :province],
        with: SocialSecurities::SocialSecurityEndowmentEntity,
        filters: { 
          type: type_filters(Types),
          province: { class: Categories::Province, title: "位置", titleize: true },
          county: fake_county_filters,
          order_by: order_by_filters(SocialSecurities::SocialSecurityEndowment),
          form: form_filters
        },
        params: {
          per: { default: 15 }
        },
        meta: {
          per: 3
        }
    end
    
  end
end
