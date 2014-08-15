class Drug::DrugType < ActiveRecord::Base
  belongs_to :parent, class_name: 'DrugType', foreign_key: 'parent_id'
  has_many :drugs, class_name: 'Drug'
end
