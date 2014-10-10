class Categories::City < ActiveRecord::Base
  belongs_to :province

  validates :name, uniqueness: true

  class << self
    include Filterable

    def generate_filter record, key = nil
      Hash.new.tap do |ret|
        ret[:title] = record.name
        ret[:params] = { city: record.id, province: record.province_id }
      end
    end

    def filters
      Categories::Province.includes(:cities).map do |province|
        cities = province.cities.load

        if cities.length == 1
          city = cities.first
          generate_filter city
        else
          Hash.new.tap do |ret|
            ret[:title] = province.name
            ret[:children] = generate_filters(cities)
          end
        end
      end
    end

    define_cached_methods :filters
  end

end
