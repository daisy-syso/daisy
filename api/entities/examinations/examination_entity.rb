class Examinations::ExaminationEntity < Bases::ItemEntity

  expose :name, :price, :image_url
  expose :examination_types, using: Examinations::ExaminationTypeEntity, as: :types

  with_options if: { detail: true } do
    expose :address, :hospital_name
    expose :examination_details, using: Examinations::ExaminationDetailEntity, as: :details
  end

  expose :template do |instance, options|
    options[:meta].try {|meta| meta[:template]} || instance.template
  end
  
end