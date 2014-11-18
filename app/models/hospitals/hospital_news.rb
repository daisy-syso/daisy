class Hospitals::HospitalNews < ActiveRecord::Base
  belongs_to :hospital_type, class_name: 'Hospitals::HospitalType'
  
  scope :hospital_type, -> (hospital_type) { hospital_type ? where(hospital_type: hospital_type) : all }

end
