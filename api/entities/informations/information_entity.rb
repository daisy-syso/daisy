class Informations::InformationEntity < ApplicationEntity

  expose :id, :name, :source, :image_url

  expose :information_type, using: Informations::InformationTypeEntity

  expose :template do |object, options|
    "infors/health_infors"
  end

  with_options if: { detail: true } do
  	expose :content, :created_at
  	expose :reviews, using: UserInfos::ReviewEntity
  end

end