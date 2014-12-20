class Hospitals::HospitalEntity < Bases::PlaceEntity
 
	expose :hospital_onsales  do |instance, options|
		instance.hospital_onsales.select {|ho| ho.hospital_charge.hospital_type_id == options[:env]["grape.request.params"].hospital_type}  
	end

  expose :template do |instance, options|
    if /\/hospitals\/polyclinics/  =~ options[:env]["PATH_INFO"]
      "hospitals/hospitals_polyclinic"     
    else
      instance.class.name.tableize
    end
  end


  with_options if: { detail: true } do
    expose :url

    expose :equipment_star, :skill_star, :service_star, :environment_star
    expose :equipment_desc, :skill_desc, :service_desc, :environment_desc
  end

  private
  
end