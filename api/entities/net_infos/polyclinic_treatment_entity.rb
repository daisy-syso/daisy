class NetInfos::PolyclinicTreatmentEntity < ApplicationEntity

  expose :id, :name

  expose :type do |object, options|
    "net_infos/polyclinic_treatments"
  end
  
  with_options if: { detail: true } do
    expose :desc, :treatment
  end

end
