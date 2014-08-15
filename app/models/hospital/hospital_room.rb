class Hospital::HospitalRoom < ActiveRecord::Base
  belongs_to :parent, class_name: 'HospitalRoom', foreign_key: 'parent_id'
end
