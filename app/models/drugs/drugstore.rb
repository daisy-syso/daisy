class Drugs::Drugstore < ActiveRecord::Base
  belongs_to :city, class_name: "Categories::City"
  belongs_to :county, class_name: "Categories::County"
  
  scope :city, -> (city) { where(city: city) }
  scope :county, -> (county) { where(county: county) }
  
  scope :is_local_hot, -> (boolean = true) {
    boolean ? where(is_local_hot: true) : where.not(is_local_hot: true)
  }
  
  # scope :query, -> (query) {
  #   query.present? ? where{name.like("%#{query}%")} : all
  # }

  scope :query, -> (query) {
    if query.present? 
      where("name_initials LIKE ? 
        or name LIKE ? 
        or address LIKE ?",
        "%#{query}%" ,
        "%#{query}%", 
        "%#{query}%"
      ) 
    else
      all
    end
  }
  
  scope :alphabet, -> (alphabet) { 
    alphabet ? where{name_initials.like("#{alphabet}%")} : all 
  }
  include Reviewable
  
end
