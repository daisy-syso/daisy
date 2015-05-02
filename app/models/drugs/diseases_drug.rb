class Drugs::DiseasesDrug < ActiveRecord::Base
	belongs_to :drug, class_name: 'Drugs::Drug'
	belongs_to :drug_type, class_name: 'Drugs::DrugType'
end