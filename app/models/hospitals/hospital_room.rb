class Hospitals::HospitalRoom < ActiveRecord::Base
  belongs_to :parent, class_name: 'HospitalRoom', foreign_key: 'parent_id'

  class << self
    include Filterable

    define_nested_filter_method :filters do
      self.all
    end
  end

end
