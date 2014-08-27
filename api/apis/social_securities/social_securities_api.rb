module SocialSecurities
  class SocialSecuritiesAPI < Grape::API
    extend ResourcesHelper

    index! :social_securities, 
      class: SocialSecurities::SocialSecurity,
      title: "医保查询",
      includes: :city
    
  end
end