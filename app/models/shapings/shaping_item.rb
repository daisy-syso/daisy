class Shapings::ShapingItem < ActiveRecord::Base
  belongs_to :shaping_type

  scope :shaping_type, -> (type) { type ? where(shaping_type: type) : all }
  
  include Reviewable
  
end
