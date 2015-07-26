class Categories::Province < ActiveRecord::Base
  self.table_name = "provinces"

  belongs_to :country, class_name: "Categories::Country"
  has_many :cities

  validates :name, uniqueness: true

  scope :country, -> (country) { where(country: country) }
  scope :by_country, -> (country) { where(country: country) if country.present? }

  class << self
    include Filterable

    define_filter_method :overses_filters do |country|
      self.country(country)
    end

    def generate_filter record, key = nil
      Hash.new.tap do |ret|
        ret[:id] = record.id
        ret[:title] = record.name
        ret[:params] = { country: record.country_id }
      end
    end

    # define_filter_method :filters do
    #   self.all
    # end

    def filters
      Categories::Country.includes(:provinces).map do |country|
        provinces = country.provinces.load

        Hash.new.tap do |ret|
          ret[:title] = country.name
          ret[:children] = generate_filters(provinces).tap do |ret|
            # prepend_filter_all ret, nil,
            #   { params: { city: nil, province: province.id }}
          end
        end
      end
    end

    define_cached_methods :filters
  end
end
