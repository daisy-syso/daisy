class Examinations::ExaminationType < ActiveRecord::Base
  # belongs_to :parent, class_name: 'ExaminationType'
  # has_many :children, class_name: 'ExaminationType', foreign_key: 'parent_id'

  class << self
    include Filterable

    define_nested_filter_method :filters, :examination_type do
      self.all
    end
  end

end
