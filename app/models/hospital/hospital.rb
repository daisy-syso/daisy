class Hospital::Hospital < ActiveRecord::Base
  belongs_to :city
  # belongs_to :type, class_name: 'HospitalType'
  has_and_belongs_to_many :types, class_name: 'HospitalType', join_table: 'hospitals_types', foreign_key: 'hospital_id', association_foreign_key: 'type_id'

end
