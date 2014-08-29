class Shapings::ShapingItem < ActiveRecord::Base
  belongs_to :shaping_type
  
  include Reviewable
  
end
