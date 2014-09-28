class SocialSecurities::SocialSecurity < ActiveRecord::Base
  belongs_to :city, class_name: "Categories::City"
  belongs_to :province, class_name: "Categories::Province"

  scope :city, -> (city) { where(city: city) }
  scope :province, -> (province) { where(province: province) }

end
