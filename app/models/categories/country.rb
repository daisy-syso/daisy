class Categories::Country < ActiveRecord::Base
  self.table_name = "countries"

  validates :name, uniqueness: true
  has_many :provinces

  class << self
    include Filterable

    define_filter_method :filters do
      self.all
    end
  end
end
