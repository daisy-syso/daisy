class Hospitals::DoctorEntity < Bases::ItemEntity

  expose :id, :position

  with_options if: { detail: true } do
    expose :desc

    expose :reviewable do |object, options|
      true
    end

    expose :hospital_room_name do |object, options|
      object.hospital_room.name rescue "未知"
    end

    expose :hospital_name do |object, options|
      object.hospital.name rescue "未知"
    end 
  end
  
end