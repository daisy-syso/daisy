class Drugs::DrugstoreEntity < Bases::PlaceEntity
	expose :Business_License

	expose :drugstore_sevice_list do |instance, options|
    {
      :yb => false,
      :qt => false,
      :ps => false
    }
  end

  with_options if: { detail: true } do
  	expose :GSP, :License, :Scope_of_business
  end
  
end