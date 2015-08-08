class Examinations::ExaminationType < ActiveRecord::Base
  
  has_many :examinations_one, class_name: 'Examinations::Examination', foreign_key: 'examination_type_one_id'
  has_many :examinations_two, class_name: 'Examinations::Examination', foreign_key: 'examination_type_two_id'
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
