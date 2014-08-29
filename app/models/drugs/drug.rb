class Drugs::Drug < ActiveRecord::Base
  belongs_to :drug_type
  belongs_to :disease

  scope :drug_type, -> (type) { type ? where(drug_type: type) : all }
  scope :disease, -> (type) { type ? where(disease: type) : all }
  scope :price, -> (from, to) {
    to ? where(ori_price: from..to) : where(arel_table[:ori_price].gt(from))
  }
  
  include Reviewable

end
