class Informations::InformationEntity < ApplicationEntity

  expose :id, :name, :source, :image_url, :is_top, :created_at

  expose :type_name do |object, options|
    object.information_type.name
  end

  expose :template do |object, options|
    "infors/health_infors"
  end

  with_options if: { detail: true } do
  	expose :content
  	expose :information_type do |object, options|
	    {
	    	id: object.information_type.id,
	    	name: object.information_type.name	   
	    }
	end
  	expose :reviews, using: UserInfos::ReviewEntity
  	expose :recommended
  	expose :hot_images
  	expose :selected
  end

end