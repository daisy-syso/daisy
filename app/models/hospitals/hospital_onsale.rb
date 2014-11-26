class Hospitals::HospitalOnsale < ActiveRecord::Base
  belongs_to :hospital_charge
  belongs_to :hospital

end