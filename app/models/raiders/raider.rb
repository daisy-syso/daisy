class Raiders::Raider < ActiveRecord::Base
  has_many :raider_details, class_name: 'Raiders::RaiderDetail', foreign_key: 'parent_id'
 



  class << self
    include Filterable

    def filters city
      generate_filters self.city(city).where.not(level: nil)
    end

    define_cached_methods :filters
  end
end
