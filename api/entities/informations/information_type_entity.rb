class Informations::InformationTypeEntity < ApplicationEntity

  expose :id, :name

  expose :template do |object, options|
    "infors/health_infors?type=#{object.id}"
  end

end