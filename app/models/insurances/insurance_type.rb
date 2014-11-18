class Insurances::InsuranceType < ActiveRecord::Base

  class << self
    include Filterable
    
    define_filter_method :filters do
      self.all
    end
  end

end
