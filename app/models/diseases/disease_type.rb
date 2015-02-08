class Diseases::DiseaseType < ActiveRecord::Base
  belongs_to :parent, class_name: 'DiseaseType', foreign_key: 'parent_id'
  has_many :children, class_name: 'DiseaseType', foreign_key: 'parent_id'
  has_many :diseases
  # has_and_belongs_to_many :diseases, class_name: "Diseases::Disease", :join_table => :diseases_types, :association_foreign_key => :disease_id
  
  class << self
    include Filterable

    define_nested_filter_method :filters do
      self.all
    end
  end

end
