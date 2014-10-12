class Eldercares::NursingRoom < ActiveRecord::Base
  belongs_to :city, class_name: "Categories::City"
  
  scope :city, -> (city) { where(city: city) }

  scope :query, -> (query) {
    query.present? ? where{name.like("%#{query}%")} : all
  }
  
  include Reviewable
  
end
