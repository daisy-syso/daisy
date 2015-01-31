class Examinations::ExaminationEntity < Bases::ItemEntity

  expose :name
  expose :examination_type 

  with_options if: { detail: true } do
    expose :applicable, :hospital_name
  end
  
end