class SocialSecurities::SocialSecurityEndowment < ActiveRecord::Base
  belongs_to :city, class_name: "Categories::City"
  belongs_to :province, class_name: "Categories::Province"

  scope :city, -> (city) { where(city: city) }
  scope :province, -> (province) {
    joins{city.outer}
      .where{(cities.province_id == province) | (province_id == province)}
    }

end
