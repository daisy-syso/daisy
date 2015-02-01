class Drugs::ManufactoryEntity < ApplicationEntity

  expose :id, :name

  expose :template do |object, options|
    "link"
  end

  expose :url do |object, options|
  	"#/list/drugs/drugs?search_by=manufactory&type=#{object.name_initials}&manufactory=#{object.id}"
  end
end