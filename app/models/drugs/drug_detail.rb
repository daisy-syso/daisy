class Drugs::DrugDetail < ActiveRecord::Base
  belongs_to :drug, class_name: "Drugs::Drug"
end