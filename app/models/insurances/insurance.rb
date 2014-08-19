class Insurances::Insurance < ActiveRecord::Base
  validates :name, uniqueness: true
  belongs_to :insurance_category
  belongs_to :insurance_company
end
