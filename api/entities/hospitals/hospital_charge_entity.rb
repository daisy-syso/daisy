class Hospitals::HospitalChargeEntity < ApplicationEntity

  expose :id, :name, :price_scope

  expose :nolink do |object, options|
    true
  end

end
