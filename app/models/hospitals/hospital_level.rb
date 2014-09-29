class Hospitals::HospitalLevel < ActiveRecord::Base
  # has_and_belongs_to_many :hospitals, join_table: 'hospitals_types', foreign_key: 'type_id'

  class << self
    include Cacheable

    def filters
      self.all.map do |hospital_level|
        { title: hospital_level.name, params: { hospital_level: hospital_level.id } }
      end
    end

    define_cached_methods :filters
  end

  before_save do
    self.position ||= self.class.count
  end

end
