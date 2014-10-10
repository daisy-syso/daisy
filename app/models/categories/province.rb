class Categories::Province < ActiveRecord::Base
  validates :name, uniqueness: true
  has_many :cities

  class << self
    include Filterable

    define_filter_method :filters, :province do
      self.all
    end
  end

end
