class Shapings::ShapingType < ActiveRecord::Base
  belongs_to :parent, class_name: 'ShapingType', foreign_key: 'parent_id'
  has_many :children, class_name: 'ShapingType', foreign_key: 'parent_id'

  class << self
    include Filterable

    define_nested_filter_method :filters, :shaping_type do
      self.all
    end
  end

end
