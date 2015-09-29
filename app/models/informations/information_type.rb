class Informations::InformationType < ActiveRecord::Base
	has_many :informations, class_name: "Informations::Information", foreign_key: 'information_type_id'
	self.table_name = "information_type"

	def latest_informations
		self.informations.order("str_to_date(created_at,'%Y-%m-%d %H:%i:%s') desc").limit(8)
	end

	def children_items
		Informations::InformationType.select('id, name').where(parent_id: self.id)
	end

end
