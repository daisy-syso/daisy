class Insurances::InsuranceEntity < ApplicationEntity

  expose :id, :name
  expose :url, as: :link

end
