class Informations::HealthInformationType < ActiveRecord::Base
	has_many :health_informations, class_name: "Informations::HealthInformation", foreign_key: 'type_id'
end
