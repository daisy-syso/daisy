class Insurance::InsuranceCompany < ActiveRecord::Base
  validates :name, uniqueness: true
end
