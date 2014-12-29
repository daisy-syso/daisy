class Examinations::ExaminationTypeEntity < Bases::ItemEntity

  expose :name
  expose :examination_charge
  # expose :template do |instance, options|
  # 	"examinations/examinations"
  # end
  expose :url do |options|
  	"#/list/examinations/examinations?type=#{options[:id]}"
  end
end