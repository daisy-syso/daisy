class Hospitals::DoctorEntity < Bases::ItemEntity

  expose :id, :position, :image_url

  expose :hospital_room_name do |object, options|
    object.hospital_room.name rescue "未知"
  end

  expose :hospital_name do |object, options|
    object.hospital.name rescue "未知"
  end 

  with_options if: { detail: true } do
    expose :desc

    expose :link do |object, options|
      object.hospital.url
    end

    expose :reviewable do |object, options|
      true
    end

    
  end
  
end