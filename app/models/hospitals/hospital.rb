class Hospitals::Hospital < ActiveRecord::Base
  belongs_to :city
  has_and_belongs_to_many :types, class_name: 'HospitalType', join_table: 'hospitals_types', foreign_key: 'hospital_id', association_foreign_key: 'type_id'

  scope :city, -> (city) { where(city: city) }

end
