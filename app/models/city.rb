class City < ActiveRecord::Base
  validates :name, uniqueness: true
  belongs_to :province
  has_many :hospitals
end
