class Shapings::ShapingItem < ActiveRecord::Base
  belongs_to :shaping_type

  scope :shaping_type, -> (type) { type ? where(shaping_type: type) : all }
  
  scope :query, -> (query) {
    query.present? ? where{name.like("%#{query}%")} : all
  }
  
  include Reviewable
  
end
