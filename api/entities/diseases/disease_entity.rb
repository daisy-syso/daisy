class Diseases::DiseaseEntity < ApplicationEntity
  
  expose :id, :name, :image_url, :desc

  with_options if: { detail: true } do
    expose :etiology, :symptoms, :examination, :treatment, :prevention, :diet
  end

  expose :params do |object, options|
  	params = options[:env]["QUERY_STRING"].split("&")
  	"type=134"
   # "common_disease=#{object.common_diseases.first.id}"
  end
end
