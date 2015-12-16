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

  def types_images
    # hash = {头条:5, 天天护理: 10, 更多: 7}
    case self.name
    when '头条'
      Informations::Information.select('id, name, image_url').unscope(:where).where(types: 5).order("created_at desc").limit(2)
    when '天天护理'
      Informations::Information.select('id, name, image_url').unscope(:where).where(types: 6).order("created_at desc").limit(2)
    end
  end

  # def hotest_images
  #   Informations::Information.select('id, name, image_url').unscope(:where).where(types: 7).order("created_at desc").limit(2)
  # end

end
