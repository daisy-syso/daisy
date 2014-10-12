class Hospitals::Hospital < ActiveRecord::Base
  belongs_to :city, class_name: "Categories::City"
  
  belongs_to :hospital_level
  has_and_belongs_to_many :hospital_types, join_table: 'hospitals_types', foreign_key: 'hospital_id', association_foreign_key: 'type_id'

  scope :city, -> (city) { where(city: city) }
  scope :hospital_type, -> (type) { 
    type ? joins(:hospital_types)
      .where{hospitals_types.type_id == type}
      .distinct : all
  }

  scope :hospital_level, -> (level = nil) {
    if level
      where(hospital_level: level)
    else
      joins(:hospital_level).order{hospital_levels.position.asc}
    end
  }

  scope :specialist, -> { 
    joins(:hospital_types)
      .where{hospital_types.specialist == true}
      .distinct
  }

  scope :has_url, -> (boolean = true) {
    boolean ? where.not(url: nil) : where(url: nil)
  }

  scope :is_local_hot, -> (boolean = true) {
    boolean ? where(is_local_hot: true) : where.not(is_local_hot: true)
  }
  
  scope :query, -> (query) {
    query.present? ? where{name.like("%#{query}%")} : all
  }

  include Localizable
  include Reviewable

  class << self
    include Filterable

    def filters city
      generate_filters self.city(city).where.not(level: nil), :hospital
    end

    define_cached_methods :filters
  end

  include Exclamationable
  def click
    self.click_count ||= 0
    self.click_count  += 1
  end
  define_exclamation_and_method :click

end
