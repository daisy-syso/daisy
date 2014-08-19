class Insurances::InsuranceCompany < ActiveRecord::Base
  validates :name, uniqueness: true
end
