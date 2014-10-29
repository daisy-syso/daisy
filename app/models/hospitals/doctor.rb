class Hospitals::Doctor < ActiveRecord::Base
  belongs_to :hospital
  belongs_to :hospital_room
  
  scope :city, -> (city) { 
    joins(:hospital)
      .where(hospitals: { city_id: city })
      .distinct 
  }
  scope :county, -> (county) { 
    joins(:hospital)
      .where(hospitals: { county_id: county })
      .distinct 
  }
  
  scope :hospital, -> (hospital) { where(hospital: hospital) }
  scope :hospital_room, -> (hospital_room) { where(hospital_room: hospital_room) }

  scope :query, -> (query) {
    query.present? ? where{name.like("%#{query}%")} : all
  }
  
  scope :hospital_query, -> (query) {
    query.present? ? joins(:hospitals)
      .where{hospitals.name.like("%#{query}%")}
      .distinct : all
  }

  scope :position_query, -> (query) {
    query.present? ? where{position.like("%#{query}%")} : all
  }

  include Reviewable

end
