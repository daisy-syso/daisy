class Informations::InformationTypeEntity < ApplicationEntity

  expose :id, :name

  expose :template do |object, options|
    "infors/health_infors?type=#{object.id}"
  end

  expose :latest_informations, using: Informations::InformationEntity

  expose :children_items

  expose :types_images

  expose :hotest_images

end