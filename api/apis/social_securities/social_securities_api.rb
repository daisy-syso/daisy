module SocialSecurities
  class SocialSecuritiesAPI < Grape::API
    extend ResourcesHelper

    namespace :social_securities do
      index! SocialSecurities::SocialSecurity,
        title: "医保查询",
        includes: :city
    end
    
  end
end