class Hospitals::HospitalType < ActiveRecord::Base

  class << self
    include Filterable

    def generate_filter record, key = nil
      Hash.new.tap do |ret|
        ret[:title] = record.name
        ret[:image_url] = record.image_url
        ret[:params] = { key => record.id } if key
      end
    end

    define_filter_method :filters do
      self.all
    end
  end

end
