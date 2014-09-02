class Province < ActiveRecord::Base
  validates :name, uniqueness: true
  has_many :cities

  class << self
    include Cacheable

    def filters
      self.all.map do |province|
        { title: province.name, params: { province: province.id } }
      end
    end

    define_cached_methods :filters
  end

end
