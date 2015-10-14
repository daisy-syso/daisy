class Informations::InformationType < ActiveRecord::Base
	has_many :informations, class_name: "Informations::Information", foreign_key: 'information_type_id'
	self.table_name = "information_type"

	attr_accessor :latest_informations

	def children_items
		Informations::InformationType.select('id, name').where(parent_id: self.id).order("created_at desc")
	end

	def parent_item
		Informations::InformationType.select('id, name').where(id: self.parent_id).first
	end

end
