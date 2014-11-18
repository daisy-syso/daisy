class Hospitals::Hospital < ActiveRecord::Base
  belongs_to :city, class_name: "Categories::City"
  belongs_to :county, class_name: "Categories::County"
  
  has_and_belongs_to_many :hospital_levels, join_table: 'hospitals_levels', association_foreign_key: 'level_id'
  has_and_belongs_to_many :hospital_types, join_table: 'hospitals_types', association_foreign_key: 'type_id'

  scope :city, -> (city) { where(city: city) }
  scope :county, -> (county) { where(county: county) }

  scope :hospital_type, -> (type) { 
    type ? joins(:hospital_types)
      .where{hospitals_types.type_id == type}
      .distinct : all
  }

  scope :hospital_level, -> (level = nil) {
    level ? joins(:hospital_levels)
      .where{hospitals_levels.level_id == level}
      .distinct : all
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
      generate_filters self.city(city).where.not(level: nil)
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
