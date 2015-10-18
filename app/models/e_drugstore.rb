class EDrugstore < ActiveRecord::Base
  belongs_to :editor

  has_many :e_drugs, dependent: :destroy
end
