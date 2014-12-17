class Hospitals::HospitalEntity < Bases::PlaceEntity
 
	expose :hospital_onsales  do |instance, options|
		instance.hospital_onsales.select {|ho| ho.hospital_charge.hospital_type_id == options[:env]["grape.request.params"].hospital_type}  
	end
  with_options if: { detail: true } do
    expose :url

    expose :equipment_star, :skill_star, :service_star, :environment_star
    expose :equipment_desc, :skill_desc, :service_desc, :environment_desc
  end

  private

  def hospital_charge
    object.hospital_onsales.each do |ho| 
    	
    	p ho.hospital_charge
    end
  end
  
end