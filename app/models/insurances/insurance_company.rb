class Insurances::InsuranceCompany < ActiveRecord::Base
	has_many :commercial_insurances, class_name: "Insurances::CommercialInsurance", foreign_key: 'company_id'
end
