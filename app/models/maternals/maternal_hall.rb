class Maternals::MaternalHall < ActiveRecord::Base
  belongs_to :city, class_name: "Categories::City"
  belongs_to :county, class_name: "Categories::County"

  scope :city, -> (city) { where(city: city) }
  scope :county, -> (county) { where(county: county) }

  scope :query, -> (query) {
    query.present? ? where{name.like("%#{query}%")} : all
  }
  
  include Localizable
  include Reviewable
  
end
