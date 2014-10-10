class Hospitals::HospitalLevel < ActiveRecord::Base

  class << self
    include Filterable

    define_filter_method :filters, :hospital_level do
      self.all
    end
  end

  before_save do
    self.position ||= self.class.count
  end

end
