class Informations::AppInformationType < ActiveRecord::Base
	has_many :app_informations, class_name: "Informations::AppInformation", foreign_key: 'type_id'
end