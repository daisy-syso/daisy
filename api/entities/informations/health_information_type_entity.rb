class Informations::HealthInformationTypeEntity < ApplicationEntity

  expose :id, :name, :image_url

  expose :health_informations do |instance, options|
  	instance.health_informations
  end

  

  

end