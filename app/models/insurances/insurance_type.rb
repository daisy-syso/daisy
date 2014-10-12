class Insurances::InsuranceType < ActiveRecord::Base

  class << self
    include Filterable
    
    define_filter_method :filters, :insurance_type do
      self.all
    end

    define_filter_method :price_search_filters, :insurance_type, false do
      self.all
    end
  end

end
