class Hospitals::HospitalTypeEntity < ApplicationEntity

  expose :id, :name
  expose :url do |instance, options|
  	"#/list/hospitals/hospital_charges?hospital_parent_type=#{instance.parent_id}&hospital_type=#{instance.id}"
  end

end