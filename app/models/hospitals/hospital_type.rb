class Hospitals::HospitalType < ActiveRecord::Base
  # has_and_belongs_to_many :hospitals, join_table: 'hospitals_types', foreign_key: 'type_id'

  scope :top_specialists, -> { where.not(id: 7)}

  class << self
    include Cacheable

    def filters
      self.all.map do |hospital_type|
        { title: hospital_type.name, params: { hospital_type: hospital_type.id } }
      end
    end

    def top_specialists_filters
      self.top_specialists.map do |hospital_type|
        { title: hospital_type.name, params: { hospital_type: hospital_type.id } }
      end
    end

    define_cached_methods :filters, :top_specialists_filters
  end

end
