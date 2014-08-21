class Hospitals::HospitalType < ActiveRecord::Base
  has_and_belongs_to_many :hospitals, join_table: 'hospitals_types', foreign_key: 'type_id'

  class << self
    include Cacheable

    def filters
      Hospitals::HospitalType.all.map do |hospital_type|
        { title: hospital_type.name, params: { hospital_type: hospital_type.id } }
      end
    end

    define_cached_methods :filters
  end

end
