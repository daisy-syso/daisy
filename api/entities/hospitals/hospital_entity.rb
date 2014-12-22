class Hospitals::HospitalEntity < Bases::PlaceEntity
 
	expose :hospital_onsales  do |instance, options|
		instance.hospital_onsales.select do |ho|
      hospital_type = options[:env].blank? ? nil : options[:env]["grape.request.params"].hospital_type
      ho.hospital_charge.hospital_type_id == hospital_type
    end 
	end

  expose :template do |instance, options|
    if /\/hospitals\/polyclinics/  =~ (options[:env].blank? ? "" : options[:env]["PATH_INFO"])
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