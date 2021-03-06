class Hospitals::Hospital < ActiveRecord::Base
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  settings index: {number_of_shards: 5} do
    mappings do
      indexes :name, type: 'string', index: :not_analyzed, analyzer: :keyword
      indexes :name_initials, boost: 50
    end
  end

  def as_indexed_json(options={})
    as_json(only: ['name','name_initials', 'city_id'])
  end

  # default_scope -> { where.not(url: [nil, ""]) }
  belongs_to :city, class_name: "Categories::City"
  belongs_to :county, class_name: "Categories::County"
  belongs_to :province, class_name: "Categories::Province"
  belongs_to :country, class_name: "Categories::Country"

  belongs_to :hospital_level, class_name: "Hospitals::HospitalLevel"
  has_many :hospital_onsales, class_name: "Hospitals::HospitalOnsale"

  has_and_belongs_to_many :hospital_types, join_table: 'hospitals_types'

  has_and_belongs_to_many :examinations, join_table: 'examinations_hospitals', 
    class_name: 'Examinations::Examination'
  has_and_belongs_to_many :examination_types, join_table: 'examinations_hospitals', 
    class_name: 'Examinations::ExaminationType'

  has_and_belongs_to_many :characteristics, join_table: 'characteristic_hospitals', class_name: 'Hospitals::Characteristic'

  scope :city, -> (city) { where(city: city) }
  scope :county, -> (county) { where(county: county) }
  scope :province, -> (province) { where(city: Categories::City.by_province(province)) }
  scope :province_oversease, -> (province) { where(city: Categories::City.by_province(province)) }
  scope :country, -> (country) { where(city: province(country)) }

  scope :hospital_type, -> (type) { 
    type ? joins(:hospital_types)
      .where{hospitals_types.hospital_type_id == type}
      .distinct : where.not(parent_id: nil)
  }
  # scope :have_examinations, -> (type) { 
  #   type ? joins(:examinations_hospitals)
  #     .where{hospitals_types.hospital_type_id == type}
  #     .distinct : where.not(parent_id: nil)
  # }

  scope :examination_type, -> (type) { 
    type ? joins(:examination_types)
      .where{examinations_hospitals.examination_type_parent_id == type}
      .distinct : all
  }

  scope :hospital_level, -> (level = nil) {
    level ? where(hospital_level: level) : order(hospital_level_id: :asc)
  }

  scope :order_by_url, -> (t = true) {
    order("url is null").order("hospital_level_id is null").order(hospital_level_id: :asc)
    # order(hospital_level_id: :desc).order(url: :desc)
  }

  # scope :joins_table_order_desc, -> (od){
  #   od ? reverse_order : all
  # }

  scope :characteristic_hospitals, ->(type = true) {
    type ? joins(:characteristics)
      .where{characteristic_hospitals.characteristic_id == type}
      .order("characteristic_hospitals.characteristic_id desc")
      .distinct : all
  }

  scope :order_by_level, -> (t = true) {
    order(hospital_level_id: :asc)
  }

  scope :order_by_telephone, -> () {
    order("telephone is null")
  }

  scope :order_by, -> (seq) {
    case seq
    when "hotest"
      order(click_count: :desc)
    when "newest"

    end
  }

  scope :has_url, -> (boolean=true) {
    boolean ? where.not(url: [nil, '']) : where(url: nil)
  }

  scope :is_local_hot, -> (boolean = true) {
    boolean ? where(is_local_hot: true) : where.not(is_local_hot: true)
  }

  scope :is_foreign, -> (boolean = true) {
    boolean ? where(is_foreign: true) : where.not(is_foreign: true)
  }

  scope :is_other, -> (boolean = true) {
    boolean ? where(is_other: true) : where.not(is_other: true)
  }

  scope :is_community, -> (boolean = true) {
    boolean ? where(is_community: true) : where.not(is_community: true)
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
    if query.present?
      # where("name LIKE :query or name_initials LIKE :query or address LIKE :query ", query: "%#{query}%")
      search(
        {
          query: {
            bool: {
              should:[
                {
                  match_phrase_prefix: {
                    name_initials: query
                  }
                },
                {
                  match_phrase_prefix: {
                    name: query
                  }
                }
              ]
            }
          }
        }
      )
    else
      all
    end
  }

  scope :is_exam, -> (b=1) {
    @examinations = Examinations::Examination.select(:hospital_id).distinct
    hospital_ids = @examinations.map do |examination|
      examination.hospital_id
    end
    @hospitals = Hospitals::Hospital.where(id: hospital_ids)
  }

  scope :special, -> (hospital_type_id){
    where(specialist: hospital_type_id)
  }

  scope :only_onsales, -> (hospital_type_id){
    @hospital_onsales = Hospitals::HospitalOnsale.joins(:hospital_charge).where(hospital_charge: { hospital_type_id: hospital_type_id })
    hospital_ids = @hospital_onsales.map {|onsale| onsale.hospital_id}
    Hospitals::Hospital.where(id: hospital_ids)
  }

  scope :extension, ->(b) {
    b ==1 ? order(extension: :desc) : order(id: :asc)
  }


  include Localizable
  include Reviewable
  include JoinAppliable

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
