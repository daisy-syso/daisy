class City < ActiveRecord::Base
  belongs_to :province
  has_many :hospitals, class_name: "Hospitals::Hospital"

  validates :name, uniqueness: true

  class << self
    include Cacheable

    def filters
      Province.includes(:cities).map do |province|
        children = province.cities.map do |city|
          { title: city.name, params: { city: city.id } }
        end
        { title: province.name, children: children }
      end
    end

    define_cached_methods :filters
  end

end
