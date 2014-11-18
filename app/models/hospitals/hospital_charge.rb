class Hospitals::HospitalCharge < ActiveRecord::Base
  belongs_to :hospital_type
  belongs_to :hospital_subtype

  scope :hospital_type, -> (type) { 
    type ? where(hospital_type: type) : all 
  }

  scope :hospital_subtype, -> (type) { 
    type ? where(hospital_subtype: type) : all 
  }

end
