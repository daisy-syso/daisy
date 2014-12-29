class Examinations::ExaminationType < ActiveRecord::Base
  # belongs_to :parent, class_name: 'ExaminationType'
  # has_many :children, class_name: 'ExaminationType', foreign_key: 'parent_id'
  has_one :examination_charge

  def self.demand_attrs
  	{ :only => [:id, :name],
  		:include => [
  			:examination_charge => [:min_price, :max_price]
  		],
  		:methods => [:template]
  	}
  end

  def template
  	"examinations/examination_types"
  end

  class << self
    include Filterable

    define_nested_filter_method :filters do
      self.all
    end
  end

end
