class Examinations::ExaminationTypeEntity < Bases::ItemEntity

  expose :name
  expose :examination_charge
  # expose :template do |instance, options|
  # 	"examinations/examinations_types"
  # end
end