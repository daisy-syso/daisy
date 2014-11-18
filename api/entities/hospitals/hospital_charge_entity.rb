class Hospitals::HospitalChargeEntity < ApplicationEntity

  expose :id, :name
  
  expose :type do |object, options|
    "link"
  end

end
