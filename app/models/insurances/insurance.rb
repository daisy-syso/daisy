class Insurances::Insurance < ActiveRecord::Base
  belongs_to :insurance_category
  belongs_to :insurance_company
  validates :name, uniqueness: true
end
