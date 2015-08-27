class Insurances::CommercialInsuranceEntity < ApplicationEntity

  expose :id, :name, :price

  with_options if: { detail: true } do
    expose :age, :company, :detail
    expose :insurance_company
   
  end

end
