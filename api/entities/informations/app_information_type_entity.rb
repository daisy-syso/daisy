class Informations::AppInformationTypeEntity < ApplicationEntity

  expose :id, :name
  expose :app_informations do |object, instance|
		object.app_informations.first(10)
	end
  

  

end