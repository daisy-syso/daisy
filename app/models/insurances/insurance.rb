class Insurances::Insurance < ActiveRecord::Base
  belongs_to :insurance_type
  belongs_to :insurance_company

  scope :insurance_type, -> (type) { type ? where(insurance_type: type) : all }

  scope :query, -> (query) {
    query.present? ? where{name.like("%#{query}%")} : all
  }
  
end
