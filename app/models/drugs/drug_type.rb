class Drugs::DrugType < ActiveRecord::Base
  belongs_to :parent, class_name: 'DrugType', foreign_key: 'parent_id'
  has_many :children, class_name: 'DrugType', foreign_key: 'parent_id'
  has_many :drugs

  class << self
    include Filterable

    define_nested_filter_method :filters do
      self.all
    end
  end

end
