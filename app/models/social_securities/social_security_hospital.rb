class SocialSecurities::SocialSecurityHospital < ActiveRecord::Base
  belongs_to :city, class_name: "Categories::City"
  
  scope :city, -> (city) { where(city: city) }
  scope :province, -> (province) { joins(:city).where(cities: { province_id: province }) }

end
