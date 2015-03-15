class Eldercares::NursingRoomEntity < Bases::PlaceEntity

  with_options if: { detail: true } do
  	expose :telephone
  end
  
end