class Drugs::Drugstore < ActiveRecord::Base
  belongs_to :city, class_name: "Categories::City"
  
  scope :city, -> (city) { where(city: city) }
  
  scope :is_local_hot, -> (boolean = true) {
    boolean ? where(is_local_hot: true) : where.not(is_local_hot: true)
  }
  
  scope :query, -> (query) {
    query.present? ? where{name.like("%#{query}%")} : all
  }
  
  include Reviewable
  
end
