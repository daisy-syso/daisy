class Hospitals::HospitalOnsaleEntity < ApplicationEntity

  expose :price, :name, :sales, :id

  expose :hospital
  expose :template do |object, options|
    "link"
  end
  
end