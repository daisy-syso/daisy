class Hospitals::HospitalNewsEntity < ApplicationEntity

  expose :id, :name, :url

  expose :template do |object, options|
    "link"
  end
  
end