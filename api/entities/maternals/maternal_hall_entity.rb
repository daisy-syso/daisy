class Maternals::MaternalHallEntity < Bases::PlaceNIEntity
  # expose :price
  	expose :image_url
	with_options if: { detail: true } do
    # expose :url
    expose :telephone
  end
end