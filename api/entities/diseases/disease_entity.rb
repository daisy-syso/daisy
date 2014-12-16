class Diseases::DiseaseEntity < ApplicationEntity
  
  expose :id, :name, :image_url, :desc

  with_options if: { detail: true } do
    expose :etiology, :symptoms, :examination, :treatment, :prevention, :diet
  end

end
