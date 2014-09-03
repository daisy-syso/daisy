class Hospitals::HospitalEntity < Bases::PlaceEntity

  with_options if: { detail: true } do
  end
  
end