class Hospitals::HospitalType < ActiveRecord::Base
  has_and_belongs_to_many :hospitals, join_table: 'hospitals_types'
  class << self
    include Filterable

    def generate_filter record
      Hash.new.tap do |ret|
        ret[:title] = record.name
        ret[:image_url] = record.image_url
        ret[:id] = record.id
      end
    end

    define_filter_method :filters do
      self.all
    end
  end

end
