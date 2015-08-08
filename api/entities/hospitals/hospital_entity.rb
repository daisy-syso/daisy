class Hospitals::HospitalEntity < Bases::PlaceEntity
  require 'rack/utils'
  expose :characteristic_departments
  expose :telephone do |instance, options|
    instance.telephone.try {|t| t[0..11]}
  end


	expose :hospital_onsales do |instance, options|
    # if options[:hospital_onsales_no_type_id]
    #   instance.hospital_onsales.sample(1)
    # elsif !options[:onsale_id].blank?
    #   Hospitals::HospitalOnsale.where(id: options[:onsale_id].blank?)
    # else
    #   hospital_type = options[:env].blank? ? nil : options[:env]["grape.request.params"].hospital_type
  		# instance.hospital_onsales.select do |ho|
    #     ho.hospital_charge.hospital_type_id == hospital_type 
    #   end
    # end

    instance.hospital_onsales.sample(1)
	end

  expose :hospital_sevice_list do |instance, options|
    hospital_type_list = instance.hospital_types.map do |hospital_type|
                          hospital_type.name
                        end
    {
      :tjjg => hospital_type_list.include?("体检") || instance.specialist == 3,
      :zhyy => hospital_type_list.include?("综合"),
      :wsyy => false,
      :dhyy => false,
      :yb => instance.medical_insurance.present? && instance.medical_insurance != "否",
      :yywz => instance.url.present?,
      :sjgh => false,
      :zkyy => instance.specialist.present?
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
    query_string =  options[:env].blank? ? "" : options[:env]["QUERY_STRING"]
    params = Rack::Utils.parse_nested_query(query_string)
    if /\/hospitals\/polyclinics/  =~ compa || /\/diseases\/diseases/ =~ compa || params["special"].present? || params['is_service'] == 'f'
      "#/detail/hospitals/hospitals/#{instance.id}" 
    elsif /\/hospitals\/test/  =~ compa
      "#/list/examinations/examinations?hospital=#{instance.id}" 
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
    expose :hospital_rooms do |object, options| 
      # doctors = Hospitals::Doctor.select("id, name, position, hospital_room_id").where(hospital_id: object.id).group_by{|d| d.hospital_room_id}
      # sub_room = doctors.map do |room_id, ds|
      #   room = Hospitals::HospitalRoom.find(room_id)
      #   {
      #     hospital_room: room.parent.present? ? room.parent.name : room.name, 
      #     doctors: ds
      #   }
      # end

 #      doctors = Hospitals::Doctor.find_by_sql("select t3.name as hospital_room, t2.name as small,t1.name from doctors t1 left join hospital_rooms t2 on t2.id=t1.hospital_room_id 
 # left join hospital_rooms t3 on t3.id=t2.parent_id  where hospital_id=15270")
 #      rooms_doctors= doctors.group_by{|d| d["hospital_room"]}
 #      rooms_doctors.map do |room, doctors|
 #        {
 #          hospital_room: room,
 #          doctors: doctors
 #        }
 #      end
        ds = Hospitals::Doctor.joins(hospital_room: :parent).where(hospital_id: object.id)
        ds.group_by{|d| d.hospital_room.parent.id}.map do |room_id, doctors|
          room = Hospitals::HospitalRoom.find(room_id)
          {
            hospital_room: room.name,
            doctors: doctors.as_json({only: [:id, :name, :position]}),
          }
        end
    end

    # hosptital_rooms: [
    #   {
    #     hosptital_rooms: xxx, 
    #     doctors: [{}, {}]
    #   }, {
    #     hosptital_rooms: xxx, 
    #     doctors: [{}, {}]
    #   }
    # ]
    #
    #
  end

  private
  
end