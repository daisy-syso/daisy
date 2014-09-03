class Hospitals::Doctor < ActiveRecord::Base
  belongs_to :hospital
  belongs_to :hospital_room
  
  scope :hospital, -> (hospital) { where(hospital: hospital) }
  scope :hospital_room, -> (hospital_room) { where(hospital_room: hospital_room) }

  include Reviewable

end
