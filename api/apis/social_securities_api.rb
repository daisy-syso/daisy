class SocialSecuritiesAPI < ApplicationAPI

  Types = {
    social_securities: "医保指定机构",
    social_security_hospitals: "医保指定医院",
    social_security_drugstores: "医保指定药店"
  }

  index! SocialSecurities::SocialSecurity,
    title: "医保查询",
    with: SocialSecurities::SocialSecurityEntity,
    params: {
      per: { default: 15 }
    },
    parent: proc {
      case params[:type].to_sym
      when :social_securities
        SocialSecurities::SocialSecurity.includes(:city)
      when :social_security_hospitals
        SocialSecurities::SocialSecurityHospital.includes(:city)
      when :social_security_drugstores
        SocialSecurities::SocialSecurityDrugstore.includes(:city)
      end
    },
    filters: { 
      province: { class: Categories::Province, title: "位置" },
      type: { 
        default: :social_securities,
        type: String,
        current: proc { |id|
          Types[id.to_sym]
        },
        children: proc {
          Types.map { |key, value| { title: value, params: { type: key }} }
        },
        has_scope: proc { |endpoint, collection, key|
          collection
        }
      }
    },
    meta: {
      per: 3
    }

end
