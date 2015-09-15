class Examinations::ExaminationTypeEntity < ApplicationEntity

  expose :name
  with_options if: { detail: true } do
  	expose :examination_charge
  end
  expose :url do |options|
  	"#/list/examinations/examinations?type=#{options[:id]}"
  end
  
end