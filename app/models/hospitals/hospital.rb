class Hospitals::Hospital < ActiveRecord::Base
  belongs_to :city
  has_and_belongs_to_many :hospital_types, join_table: 'hospitals_types', foreign_key: 'hospital_id', association_foreign_key: 'type_id'

  scope :city, -> (city) { where(city: city) }
  scope :hospital_type, -> (type) { type ? joins(:hospital_types)
    .where(:"hospitals_types.type_id" => type) : all }

  class << self
    include Cacheable

    def filters
      Province.includes(:cities).map do |province|
        children = province.cities.map do |city|
          { title: city.name, children: children, link: "filters/hospitals?city=#{city.id}" }
        end
        { title: province.name, children: children }
      end
    end

    define_cached_methods :filters
  end

end
