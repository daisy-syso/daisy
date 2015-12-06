class Informations::Information < ActiveRecord::Base

  belongs_to :information_type, class_name: "Informations::InformationType", foreign_key: 'information_type_id'

  self.table_name = "informations"

  include Reviewable

  # default_scope { where(types: 0) }   # 普通资讯
  scope :guessed, -> { unscope(:where).where types: 1 }  #猜你喜欢资讯
  scope :recommended, -> { unscope(:where).where types: 2 }  #推荐资讯
  scope :selected, -> { unscope(:where).where types: 3 }  #精选资讯

  def recommended
    Informations::Information.unscope(:where).select('id, name').where.not(id: self.id).order("str_to_date(created_at,'%Y-%m-%d %H:%i:%s') desc").limit(8)
  end

  def hot_images
    Informations::Information.unscope(:where).select('id, name, image_url').where.not(id: self.id, image_url: nil).order("str_to_date(created_at,'%Y-%m-%d %H:%i:%s') desc").limit(8)
  end

  def selected
    Informations::Information.unscope(:where).select('id, name').where.not(id: self.id).order("read_count desc").limit(8)
  end
end
