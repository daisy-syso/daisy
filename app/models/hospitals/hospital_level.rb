class Hospitals::HospitalLevel < ActiveRecord::Base

  scope :form, -> { where(id: [8,9,4]).order(:position) }

  class << self
    include Filterable
    generate_form_filters
    
    define_filter_method :filters, :hospital_level do
      self.all
    end

    define_filter_method :form_filters, :hospital_level do
      self.form
    end
  end

  before_save do
    self.position ||= self.class.count
  end

end
