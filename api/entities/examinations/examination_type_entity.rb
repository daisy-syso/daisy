class Examinations::ExaminationTypeEntity < ApplicationEntity

  expose :name
  expose :examination_charge
  expose :url do |options|
  	"#/list/examinations/examinations?type=#{options[:id]}"
  end
  
end