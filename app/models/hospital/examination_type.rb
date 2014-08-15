class Hospital::ExaminationType < ActiveRecord::Base
  belongs_to :parent, class_name: 'ExaminationType'
  has_many :examinations
end
