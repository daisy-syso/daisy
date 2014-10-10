class Hospitals::HospitalType < ActiveRecord::Base
  scope :top_specialists, -> { where.not(id: 7) }
  scope :price_search, -> { where(id: [1,4,5,6]) }

  class << self
    include Filterable

    define_filter_method :filters, :hospital_type do
      self.all
    end

    define_filter_method :top_specialists_filters, :hospital_type do
      self.top_specialists
    end

    define_filter_method :price_search_filters, :hospital_type do
      self.price_search
    end
  end

end
