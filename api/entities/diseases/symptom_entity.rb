class Diseases::SymptomEntity < ApplicationEntity
  
  expose :id, :name, :xgjc, :xgzz, :xgyp, :xgjb

  expose :params do |object, options|
  	params = options[:env]["QUERY_STRING"].split("&")
  	"type=134"
   # "common_disease=#{object.common_diseases.first.id}"
  end
end
