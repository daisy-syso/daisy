class Insurance::InsuranceCategory < ActiveRecord::Base
  validates :name, uniqueness: true
end
