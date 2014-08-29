class Drugs::Drugstore < ActiveRecord::Base
  belongs_to :city
  
  scope :city, -> (city) { where(city: city) }
  
  include Reviewable
  
end
