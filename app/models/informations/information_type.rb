class Informations::InformationType < ActiveRecord::Base
	has_many :informations, class_name: "Informations::Information", foreign_key: 'information_type_id'
	self.table_name = "information_type"
end
