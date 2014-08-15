class Hospital::HospitalType < ActiveRecord::Base
  has_and_belongs_to_many :hospitals, join_table: 'hospitals_types', foreign_key: 'type_id'
end
