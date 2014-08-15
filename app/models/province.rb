class Province < ActiveRecord::Base
  validates :name, uniqueness: true
  has_many :cities
end
