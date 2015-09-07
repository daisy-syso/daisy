class Hospitals::HospitalOnsaleEntity < ApplicationEntity

  expose :price, :name, :sales, :id, :sales_volume, :original_price

  expose :hospital do |object, options|
    if object.hospital_charge.hospital_type_parent_id == 4
    	object.hall
    else
    	object.hospital
    end
  end
  expose :hall
  expose :template do |object, options|
    "link"
  end

  expose :reviews_counts do |object, options|
  	object.reviews.count
  end
  
end