class DrugType < ActiveRecord::Base
  self.table_name = "drug_type"

  belongs_to :parent, class_name: 'DrugType', foreign_key: 'parent_id'
  has_many :children, class_name: 'DrugType', foreign_key: 'parent_id'
end
