class Categories::City < ActiveRecord::Base
  belongs_to :province

  validates :name, uniqueness: true

  class << self
    include Cacheable

    def filters
      Categories::Province.includes(:cities).map do |province|
        cities = province.cities.load
        city_proc = proc do |city|
          { title: city.name, params: { city: city.id, province: city.province_id }}
        end
        
        if cities.length == 1
          city = cities.first
          city_proc.call city
        else
          children = cities.map do |city|
            city_proc.call city
          end
          { title: province.name, children: children }
        end
      end
    end

    define_cached_methods :filters
  end

end
