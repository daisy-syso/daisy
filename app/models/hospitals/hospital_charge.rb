class Hospitals::HospitalCharge < ActiveRecord::Base
  belongs_to :hospital_type
  
  scope :hospital_parent_type, -> (type) { 
    type ? where(hospital_type_parent_id: type) : all 
  }

  scope :hospital_type, -> (type) { 
    type ? where(hospital_type_id: type) : all 
  }

end
