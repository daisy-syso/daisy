class Drugs::Drug < ActiveRecord::Base
  belongs_to :drug_type
  has_and_belongs_to_many :diseases, class_name: "Diseases::Disease"

  scope :drug_type, -> (type) { type ? where(drug_type: type) : all }
  scope :disease, -> (type) { type ? joins(:diseases)
    .where(diseases_drugs: { disease_id: type }) : all }
  scope :price, -> (from, to) {
    to ? where(ori_price: from..to) : where{ori_price > from}
  }
  
  include Reviewable

end
