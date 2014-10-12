class Maternals::ConfinementCenter < ActiveRecord::Base
  belongs_to :city, class_name: "Categories::City"
  
  scope :city, -> (city) { where(city: city) }

  scope :has_url, -> (boolean = true) {
    boolean ? where.not(url: nil) : where(url: nil)
  }

  scope :query, -> (query) {
    query.present? ? where{name.like("%#{query}%")} : all
  }
  
  include Localizable
  include Reviewable
  
end
