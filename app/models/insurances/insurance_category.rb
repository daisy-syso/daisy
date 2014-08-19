class Insurances::InsuranceCategory < ActiveRecord::Base
  validates :name, uniqueness: true
end
