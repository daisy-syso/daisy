class Maternals::ConfinementCenter < ActiveRecord::Base
  belongs_to :city, class_name: "Categories::City"
  
  scope :city, -> (city) { where(city: city) }

  include Localizable
  include Reviewable
  
end
