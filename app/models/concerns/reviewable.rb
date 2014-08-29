module Reviewable
  extend ActiveSupport::Concern
  

  included do
    has_many :reviews, as: :item
    
    include Cacheable

    def star
      reviews.average(:star)
    end
    
    def reviews_count
      reviews.count
    end
    define_cached_methods :star, :reviews_count
  end


end