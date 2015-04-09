class Maternals::ConfinementCenterEntity < Bases::PlaceNIEntity
	expose :price, :image_url
	with_options if: { detail: true } do
    expose :url
    expose :telephone
    # expose :equipment_star, :skill_star, :service_star, :environment_star
    # expose :equipment_desc, :skill_desc, :service_desc, :environment_desc
  end
end