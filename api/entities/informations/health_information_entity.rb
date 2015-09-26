class Informations::HealthInformationEntity < ApplicationEntity

  expose :id, :name, :url, :image_url

  expose :health_information_type, using: Informations::HealthInformationTypeEntity

  expose :template do |object, options|
    "infors/health_infors"
  end

  with_options if: { detail: true } do
  	expose :content, :created_at
  	expose :reviews, using: UserInfos::ReviewEntity
  end

end