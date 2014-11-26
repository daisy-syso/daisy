class Examinations::Examination < ActiveRecord::Base
  belongs_to :city, class_name: "Categories::City"
  belongs_to :examination_type

  scope :city, -> (city) { where(city: city) }
  scope :examination_type, -> (type) { 
    type ? where(examination_type_id: type) : all 
  }
  scope :examination_parent_type, -> (type) { 
    type ? where(examination_type_parent_id: type) : all 
  }

  scope :price, -> (to, from = 0) {
    to ? where(price: from..to) : where{price > from}
  }

  scope :hospital_query, -> (query) {
    query.present? ? where{hospital_name.like("%#{query}%")} : all
  }

  scope :applicable_query, -> (query) {
    query.present? ? where{applicable.like("%#{query}%")} : all
  }

  include Reviewable
  
  alias_attribute :sale_price, :price
  def ori_price
    sale_price + save_price
  end
  
end
