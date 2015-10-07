class Informations::Information < ActiveRecord::Base
	belongs_to :information_type, class_name: "Informations::InformationType", foreign_key: 'information_type_id'
	self.table_name = "informations"
	include Reviewable

	def recommended
		Informations::Information.select('id, name').where.not(id: self.id).order("str_to_date(created_at,'%Y-%m-%d %H:%i:%s') desc").limit(8)
	end

	def hot_images
		Informations::Information.select('id, name, image_url').where.not(id: self.id, image_url: nil).order("str_to_date(created_at,'%Y-%m-%d %H:%i:%s') desc").limit(8)
	end

	def selected
		Informations::Information.select('id, name').where.not(id: self.id).order("str_to_date(created_at,'%Y-%m-%d %H:%i:%s') desc").limit(8)
	end
end
