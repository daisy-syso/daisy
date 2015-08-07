class Eldercares::NursingRoomEntity < Bases::PlaceEntity

	expose :bed, :target, :price, :nature, :mold, :service

  with_options if: { detail: true } do
  	expose :telephone
  end
  
end