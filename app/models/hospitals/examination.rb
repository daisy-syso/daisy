class Hospitals::Examination < ActiveRecord::Base
  belongs_to :city
  belongs_to :examination_type

  scope :city, -> (city) { where(city: city) }
  scope :examination_type, -> (type) { type ? where(examination_type: type) : all }

  include Reviewable
  
end
