class Examinations::ExaminationCharge < ActiveRecord::Base
  # belongs_to :parent, class_name: 'ExaminationType'
  # has_many :children, class_name: 'ExaminationType', foreign_key: 'parent_id'
  belongs_to :examination_type

  class << self
    include Filterable

    define_nested_filter_method :filters do
      self.all
    end
  end

end
