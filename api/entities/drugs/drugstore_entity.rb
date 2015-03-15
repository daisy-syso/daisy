class Drugs::DrugstoreEntity < Bases::PlaceEntity
	expose :Business_License
  with_options if: { detail: true } do
  end
  
end