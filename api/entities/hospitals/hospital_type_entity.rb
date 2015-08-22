class Hospitals::HospitalTypeEntity < ApplicationEntity

  expose :id, :name
  expose :url do |instance, options|
  	"#/list/hospitals/hospital_charges?hospital_parent_type=#{instance.parent_id}&hospital_type=#{instance.id}"
  end

  expose :charges, using: Hospitals::HospitalChargeEntity, unless: lambda { |status, options| options[:privileges] } do |instance, options|
  	Hospitals::HospitalCharge.hospital_type(instance.id)
	end 
 
	with_options if: { privileges: true } do
		unexpose :url
		unexpose :template
		expose :image_url
		expose :children do |obj, opt|
			Hospitals::HospitalTypeEntity.represent(obj.hospital_types, only: [:id, :name])
		end
	end

end



