class Hospitals::HospitalOnsale < ActiveRecord::Base
  belongs_to :hospital_charge, class_name: "Hospitals::HospitalCharge"
  belongs_to :hospital, class_name: "Hospitals::Hospital"

end