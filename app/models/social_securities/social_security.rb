class SocialSecurities::SocialSecurity < ActiveRecord::Base
  belongs_to :city

  scope :city, -> (city) { where(city: city) }
  scope :province, -> (province) { joins(:city).where(cities: { province_id: province }) }

end
