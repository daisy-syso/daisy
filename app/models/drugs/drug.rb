class Drugs::Drug < ActiveRecord::Base
  belongs_to :drug_type
  has_and_belongs_to_many :diseases, class_name: "Diseases::Disease"

  scope :drug_type, -> (type) { type ? where(drug_type: type) : all }
  
  scope :disease, -> (type) { 
    type ? joins(:diseases)
      .where(diseases_drugs: { disease_id: type })
      .distinct : all 
  }

  scope :query, -> (query) {
    query.present? ? where{name.like("%#{query}%")} : all
  }
  
  scope :manufactory_query, -> (query) {
    query.present? ? where{manufactory.like("%#{query}%")} : all
  }
  
  scope :price, -> (to, from = 0) {
    to ? where(ori_price: from..to) : where{ori_price > from}
  }
  
  include Reviewable

end
