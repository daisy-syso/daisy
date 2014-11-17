class SocialSecurities::SocialSecurity < ActiveRecord::Base
  belongs_to :city, class_name: "Categories::City"
  belongs_to :province, class_name: "Categories::Province"
  belongs_to :social_security_type

  scope :city, -> (city) { where(city: city) }
  scope :province, -> (province) { where(province: province) }
  scope :social_security_type, -> (type) { type ? where(social_security_type: type) : all }
end
