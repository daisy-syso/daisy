class Hospitals::DoctorEntity < Bases::ItemEntity

  expose :id, :position

  with_options if: { detail: true } do
    expose :desc
    
    expose :hospital_room_name do |object, options|
      object.hospital_room.name
    end

    expose :hospital_name do |object, options|
      object.hospital.name
    end 
  end
  
end