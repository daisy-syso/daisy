class Drugs::ManufactoryEntity < ApplicationEntity

  expose :id, :name

  expose :template do |object, options|
    "link"
  end
  
end