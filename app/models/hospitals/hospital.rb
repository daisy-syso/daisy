class Hospitals::Hospital < ActiveRecord::Base
  belongs_to :city, class_name: "Categories::City"
  
  belongs_to :hospital_level
  has_and_belongs_to_many :hospital_types, join_table: 'hospitals_types', foreign_key: 'hospital_id', association_foreign_key: 'type_id'

  scope :city, -> (city) { where(city: city) }
  scope :hospital_type, -> (type) { 
    case type
    when 1..6
      joins(:hospital_types)
        .where(hospitals_types: { type_id: type })
        .distinct
    when 7
      joins(:hospital_types)
        .where(hospitals_types: { type_id: type })
        .where.not(level: nil)
        .distinct
    else
      all
    end
  }

  scope :top_specialists, -> () { 
    joins(:hospital_types)
      .where.not(hospitals_types: { type_id: 7 })
      .distinct
  }

  include Localizable
  include Reviewable

  class << self
    include Cacheable

    def filters city
      self.city(city).where.not(level: nil).map do |hospital|
        { title: hospital.name, params: { hospital: hospital.id }}
      end
    end

    # define_cached_methods :filters
  end

  include Exclamationable
  def click
    self.click_count ||= 0
    self.click_count  += 1
  end
  define_exclamation_and_method :click

end
