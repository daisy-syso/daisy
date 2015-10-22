class Informations::RecommendedInformation < ActiveRecord::Base

	belongs_to :information_type, class_name: "Informations::InformationType", foreign_key: 'information_type_id'

	self.table_name = "informations"

	include Reviewable

	default_scope { where(types: 1) }

end
