class Drugs::Disease < ActiveRecord::Base
  belongs_to :drug_type
  
  scope :drug_type, -> (type) { type ? where(drug_type: type) : all }

end
