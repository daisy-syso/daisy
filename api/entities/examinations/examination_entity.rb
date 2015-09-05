class Examinations::ExaminationEntity < Bases::ItemEntity

  expose :name, :price, :image_url
  expose :examination_type, using: Examinations::ExaminationTypeEntity

  with_options if: { detail: true } do
    expose :address, :hospital_name
    expose :examination_details, using: Examinations::ExaminationDetailEntity
  end

  expose :template do |instance, options|
    options[:meta].try {|meta| meta[:template]} || instance.template
  end
  
end