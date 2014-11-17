class Hospitals::HospitalEntity < Bases::PlaceEntity

  with_options if: { detail: true } do
    expose :url

    expose :equipment_star, :skill_star, :service_star, :environment_star
    expose :equipment_desc, :skill_desc, :service_desc, :environment_desc
  end
  
end