class Diseases::DiseaseEntity < ApplicationEntity
  
  expose :id, :name, :desc

  with_options if: { detail: true } do
    expose :etiology, :symptoms, :examination, :treatment, :prevention, :diet
  end

end
