class Hospitals::HospitalType < ActiveRecord::Base
  scope :specialist, -> { where(specialist: true) }
  scope :price_search, -> { where(price_search: true) }

  class << self
    include Filterable

    def generate_filter record, key = nil
      Hash.new.tap do |ret|
        ret[:title] = record.name
        ret[:image_url] = record.image_url
        ret[:params] = { key => record.id } if key
      end
    end

    define_filter_method :filters, :hospital_type do
      self.all
    end

    define_filter_method :specialist_filters, :hospital_type do
      self.specialist
    end

    define_filter_method :price_search_filters, :hospital_type do
      self.price_search
    end
  end

end
