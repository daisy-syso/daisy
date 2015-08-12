class Categories::City < ActiveRecord::Base
  self.table_name = "cities"

  belongs_to :province, class_name: "Categories::Province"

  validates :name, uniqueness: true

  scope :province, -> (province) { where(province: province) }
  scope :by_province, -> (province) { where(province: province) }

  class << self
    include Filterable

    define_filter_method :overses_filters do |province|
      self.province(province)
    end

    def generate_filter record, key = nil
      Hash.new.tap do |ret|
        ret[:id] = record.id
        ret[:title] = record.name
        ret[:params] = { province: record.province_id }
      end
    end

    def filters(country_id = nil)
      Categories::Province.where(country_id: 1).by_country(country_id).includes(:cities).map do |province|
        cities = province.cities.load

        if cities.length == 1
          city = cities.first
          generate_filter city
        else
          Hash.new.tap do |ret|
            ret[:title] = province.name
            ret[:children] = generate_filters(cities).tap do |ret|
              # prepend_filter_all ret, nil,
              #   { params: { city: nil, province: province.id }}
            end
          end
        end
      end
    end

    define_cached_methods :filters
  end

end
