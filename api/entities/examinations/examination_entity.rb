class Examinations::ExaminationEntity < Bases::ItemEntity

  expose :ori_price, :sale_price, :feature
  expose :examination_type 

  with_options if: { detail: true } do
    expose :applicable, :hospital_name
  end
  
end