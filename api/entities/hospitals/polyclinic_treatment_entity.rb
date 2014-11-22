class Hospitals::PolyclinicTreatmentEntity < ApplicationEntity

  expose :id, :name

  expose :template do |object, options|
    "hospitals/polyclinic_treatments"
  end
  
  with_options if: { detail: true } do
    expose :desc, :treatment
  end

end
