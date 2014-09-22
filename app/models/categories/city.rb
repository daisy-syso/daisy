class Categories::City < ActiveRecord::Base
  belongs_to :province

  validates :name, uniqueness: true

  class << self
    include Cacheable

    def filters
      Categories::Province.includes(:cities).map do |province|
        cities = province.cities.load
        if cities.length == 1
          city = cities.first
          { title: city.name, params: { city: city.id }}
        else
          children = cities.map do |city|
            { title: city.name, params: { city: city.id }}
          end
          { title: province.name, children: children }
        end
      end
    end

    define_cached_methods :filters
  end

end
