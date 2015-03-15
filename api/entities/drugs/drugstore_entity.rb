class Drugs::DrugstoreEntity < Bases::PlaceEntity
	expose :Business_License
  with_options if: { detail: true } do
  	expose :GSP, :License, :Scope_of_business
  end
  
end