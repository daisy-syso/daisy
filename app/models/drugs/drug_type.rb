class Drugs::DrugType < ActiveRecord::Base
  belongs_to :parent, class_name: 'DrugType', foreign_key: 'parent_id'
  has_many :children, class_name: 'DrugType', foreign_key: 'parent_id'
  # has_many :drugs
  # has_and_belongs_to_many :drugs, class_name: "Drugs::DrugType", join_table: 'diseases_drugs', foreign_key: 'disease_id', association_foreign_key: "drug_id"

  class << self
    include Filterable

    define_nested_filter_method :filters do
      self.all
    end
  end

end
