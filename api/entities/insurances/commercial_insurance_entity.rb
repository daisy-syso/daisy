class Insurances::CommercialInsuranceEntity < ApplicationEntity

  expose :id, :name, :price

  with_options if: { detail: true } do
    expose :age, :company, :detail

   
  end

end
