class Informations::Information < ActiveRecord::Base
	belongs_to :information_type, class_name: "Informations::InformationType", foreign_key: 'information_type_id'
	self.table_name = "informations"
	include Reviewable
end
