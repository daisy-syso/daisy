class Categories::County < ActiveRecord::Base
  self.table_name = "counties"
  belongs_to :city, class_name: "Categories::City"

  scope :city, -> (city) { where(city: city) }

  class << self
    include Filterable

    define_filter_method :filters do |city|
      self.city(city)
    end
  end
end