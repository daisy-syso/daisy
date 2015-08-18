class Drugs::ManufactoryEntity < ApplicationEntity

  expose :id, :name

  expose :template do |object, options|
    "link"
  end

  expose :url do |object, options|
  	"#/list/drugs/drugs?search_by=manufactory&type=#{object.name_initials}&manufactory=#{object.id}"
  end

  with_options if: { detail: true } do
    expose :url, :telephone, :image_url, :address
    
  end
end