class NetInfos::HospitalTypeNews < ActiveRecord::Base
  belongs_to :hospital_type, class_name: "Hospitals::HospitalType"
end