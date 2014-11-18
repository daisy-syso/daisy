class Hospitals::HospitalLevel < ActiveRecord::Base

  class << self
    include Filterable
    generate_form_filters
    
    define_filter_method :filters, false do
      self.all
    end

    define_filter_method :form_filters, false do
      self.all
    end
  end

  before_save do
    self.position ||= self.class.count
  end

end
