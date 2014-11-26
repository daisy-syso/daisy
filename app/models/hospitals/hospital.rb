class Hospitals::Hospital < ActiveRecord::Base
  belongs_to :city, class_name: "Categories::City"
  belongs_to :county, class_name: "Categories::County"
  
  belongs_to :hospital_level
  has_many :hospital_onsales

  has_and_belongs_to_many :hospital_types, join_table: 'hospitals_types'

  has_and_belongs_to_many :examinations, join_table: 'examinations_hospitals', 
    class_name: 'Examinations::Examination'
  has_and_belongs_to_many :examination_types, join_table: 'examinations_hospitals', 
    class_name: 'Examinations::ExaminationType'


  scope :city, -> (city) { where(city: city) }
  scope :county, -> (county) { where(county: county) }

  scope :hospital_type, -> (type) { 
    type ? joins(:hospital_types)
      .where{hospitals_types.hospital_type_id == type}
      .distinct : all
  }

  scope :examination_type, -> (type) { 
    type ? joins(:examination_types)
      .where{examinations_hospitals.examination_type_parent_id == type}
      .distinct : all
  }

  scope :hospital_level, -> (level = nil) {
    level ? where(hospital_level: level) : order{hospital_level_id.desc}
  }

  scope :has_url, -> (boolean = true) {
    boolean ? where.not(url: nil) : where(url: nil)
  }

  scope :is_local_hot, -> (boolean = true) {
    boolean ? where(is_local_hot: true) : where.not(is_local_hot: true)
  }

  scope :has_mobile_url, -> (boolean = true) {
    boolean ? where.not(mobile_url: nil) : where(mobile_url: nil)
  }
  
  scope :template, -> (type) {
    case type.to_i
    when 1
      is_local_hot
    when 2
      has_url
    end
  }

  scope :alphabet, -> (alphabet) {
    alphabet ? where{name_initials.like("#{alphabet}%")} : all 
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
