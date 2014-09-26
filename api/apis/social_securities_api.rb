class SocialSecuritiesAPI < ApplicationAPI

  Types = {
    :"social_securities/social_securities" => "医保指定机构",
    :"social_securities/social_security_hospitals" => "医保指定医院",
    :"social_securities/social_security_drugstores" => "医保指定药店",
    :"social_securities/social_security_drugs" => "医保指定药品",
    :"social_securities/social_security_endowments" => "社保养老",
  }

  class << self
    def index_options current
      {
        title: Types[current],
        includes: :city,
        with: SocialSecurities::SocialSecurityEntity,
        filters: { 
          province: { class: Categories::Province, title: "位置", titleize: true },
          type: type_filters(Types, current)
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
        index_options(:"social_securities/social_securities")
    end

    namespace :social_security_hospitals do
      index! SocialSecurities::SocialSecurityHospital, 
        index_options(:"social_securities/social_security_hospitals")
    end

    namespace :social_security_drugstores do
      index! SocialSecurities::SocialSecurityDrugstore, 
        index_options(:"social_securities/social_security_drugstores")
    end

    namespace :social_security_drugs do
      index! SocialSecurities::SocialSecurityDrug, 
        index_options(:"social_securities/social_security_drugs")
    end

    namespace :social_security_endowments do
      index! SocialSecurities::SocialSecurityEndowment,
        title: Types[:"social_securities/social_security_endowments"],
        includes: [:city, :province],
        with: SocialSecurities::SocialSecurityEndowmentEntity,
        filters: { 
          province: { class: Categories::Province, title: "位置", titleize: true },
          type: type_filters(Types, :"social_securities/social_security_endowments")
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
