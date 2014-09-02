class Drugs::Drugstore < ActiveRecord::Base
  belongs_to :city, class_name: "Categories::City"
  
  scope :city, -> (city) { where(city: city) }
  
  include Reviewable
  
end
