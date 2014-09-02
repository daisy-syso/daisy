class SocialSecurities::SocialSecuritiesAPI < Grape::API
  extend ResourcesHelper

  namespace :social_securities do
    index! SocialSecurities::SocialSecurity,
      title: "医保查询",
      includes: :city,
      filters: { 
        province: { class: Categories::Province, title: "位置" },
      }
  end
end
