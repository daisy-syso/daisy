class Hospitals::HospitalEntity < Bases::PlaceEntity
  
  expose :characteristic_departments
  expose :telephone do |instance, options|
    instance.telephone.try {|t| t[0..11]}
  end


	expose :hospital_onsales do |instance, options|
    if options[:hospital_onsales_no_type_id]
      instance.hospital_onsales.sample(1)
    elsif !options[:onsale_id].blank?
      Hospitals::HospitalOnsale.where(id: options[:onsale_id].blank?)
    else
      hospital_type = options[:env].blank? ? nil : options[:env]["grape.request.params"].hospital_type
  		instance.hospital_onsales.select do |ho|
        ho.hospital_charge.hospital_type_id == hospital_type 
      end
    end
	end

  expose :hospital_sevice_list do |instance, options|
    hospital_type_list = instance.hospital_types.map do |hospital_type|
                          hospital_type.name
                        end
    {
      :tjjg => hospital_type_list.include?("体检"),
      :zhyy => hospital_type_list.include?("综合"),
      :wsyy => false,
      :dhyy => false,
      :yb => instance.medical_insurance.present? && instance.medical_insurance != "否"
      :yywz => instance.url.present?
      :sjgh => 
    }
  end

  expose :hospital_type_list do |instance, options|
    
    instance.hospital_types.map do |hospital_type|
      hospital_type.name
    end
  end

  # with_options if: {hospital_onsales_no_type_id: true} do
  #   expose :hospital_onsales do |instance, options|
  #     instance.hospital_onsales.sample(1)
  #   end
  # end

  expose :url do |instance, options|
    # hospital_type = options[:env].blank? ? nil : options[:env]["grape.request.params"].hospital_type
    # if hospital_type
    # "#/detail/hospitals/hospital_onsales/#{instance.hospital_onsales.first.try(:id)}"
    # end
    compa = options[:env].blank? ? "" : options[:env]["PATH_INFO"]
    if /\/hospitals\/polyclinics/  =~ compa || options[:hospital_onsales_no_type_id] || /\/diseases\/diseases/ =~ compa
      "#/detail/hospitals/hospitals/#{instance.id}" 
    elsif options[:detail]
      instance.url
    else
      "#/detail/hospitals/hospital_onsales/#{instance.hospital_onsales.first.try(:id)}"
    end
  end

  expose :template do |instance, options|
    # hospital_type = instance.hospital_types
    # p "options========#{options}"
    # p "options[:meta]======#{options[:meta]}"
    compa = options[:env].blank? ? "" : options[:env]["PATH_INFO"]
    if /\/hospitals\/polyclinics/  =~ compa || options[:hospital_onsales_no_type_id] || /\/diseases\/diseases/ =~ compa || /\/hospitals\/characteristics/ =~ compa
      t = "hospitals/hospitals_polyclinic"     
    else
      t = instance.class.name.tableize
    end
    options[:meta].try {|meta| meta[:template]} || t
  end

  expose :related do |instance, options|
    true
  end


  with_options if: { detail: true } do
    # expose :url
    # expose :telephone
    expose :medical_insurance
    expose :equipment_star, :skill_star, :service_star, :environment_star
    expose :equipment_desc, :skill_desc, :service_desc, :environment_desc
  end

  private
  
end