class Hospitals::NursingRoom < ActiveRecord::Base
  belongs_to :city
  
  scope :city, -> (city) { where(city: city) }

end
