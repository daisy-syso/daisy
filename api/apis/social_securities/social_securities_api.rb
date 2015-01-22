class SocialSecurities::SocialSecuritiesAPI < ApplicationAPI

  namespace :social_securities do
    index! SocialSecurities::SocialSecurity, 
      title: "医保查询",
      filters: { 
        type: type_filters("医保查询", :social_security),
        city: city_filters,
        social_security_type: { default: 1, scope_only: true },
        county: fake_county_filters,
        order_by: order_by_filters(SocialSecurities::SocialSecurity),
        form: form_filters
      }
  end
end
