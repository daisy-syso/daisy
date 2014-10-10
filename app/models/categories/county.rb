class Categories::County < ActiveRecord::Base
  belongs_to :city, class_name: "Categories::City"
  
  scope :city, -> (city) { where(city: city) }

  class << self
    include Filterable

    def filters city
      generate_filters self.city(city), :county
    end

    define_cached_methods :filters
  end
end