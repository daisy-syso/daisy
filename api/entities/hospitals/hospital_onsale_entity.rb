class Hospitals::HospitalOnsaleEntity < ApplicationEntity

  expose :price, :name, :sales

  expose :hospital
  expose :template do |object, options|
    "link"
  end
  
end