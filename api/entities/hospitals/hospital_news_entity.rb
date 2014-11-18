class Hospitals::HospitalNewsEntity < ApplicationEntity

  expose :id, :name, :url

  expose :type do |object, options|
    "link"
  end
  
end