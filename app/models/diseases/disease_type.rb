class Diseases::DiseaseType < ActiveRecord::Base
  belongs_to :parent, class_name: 'DiseaseType', foreign_key: 'parent_id'
  has_many :children, class_name: 'DiseaseType', foreign_key: 'parent_id'
  has_many :diseases

  class << self
    include Filterable

    define_nested_filter_method :filters, :disease_type do
      self.all
    end
  end

end
