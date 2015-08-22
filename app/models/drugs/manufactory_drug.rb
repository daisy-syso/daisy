class Drugs::ManufactoryDrug < ActiveRecord::Base
	has_and_belongs_to_many :drugs, class_name: "Drugs::Drug"
	has_and_belongs_to_many :manufactories, class_name: "Drugs::Manufactory"

end

