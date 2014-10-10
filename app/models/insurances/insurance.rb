class Insurances::Insurance < ActiveRecord::Base
  belongs_to :insurance_type
  belongs_to :insurance_company

end
