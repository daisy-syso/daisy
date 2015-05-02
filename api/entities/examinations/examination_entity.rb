class Examinations::ExaminationEntity < Bases::ItemEntity

  expose :ori_price, :sale_price, :feature, :image_url
  expose :examination_type 

  with_options if: { detail: true } do
    expose :applicable, :hospital_name
  end

  expose :template do |instance, options|
    options[:meta].try {|meta| meta[:template]} || instance.template
  end
  
end