class Hospitals::HospitalOnsaleEntity < ApplicationEntity

  expose :price, :name, :sales, :id, :sales_volume, :original_price

  expose :hospital
  expose :template do |object, options|
    "link"
  end

  expose :reviews_counts do |object, options|
  	object.reviews.count
  end
  
end