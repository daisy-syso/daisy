class Diseases::DiseaseDetail < ActiveRecord::Base
	belongs_to :disease, class_name: "Diseases::Disease"
end