class Maternals::MaternalHallEntity < Bases::PlaceNIEntity
  # expose :price
	with_options if: { detail: true } do
    # expose :url
    expose :telephone
  end
end