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

  def video_category
    case self.name
    when '头条'
      video_category = VideoCategory.select('id, name').where(name: '资讯').first
    when '养生'
      video_category = VideoCategory.select('id, name').where(name: '养生').first
    when '长寿'
      video_category = VideoCategory.select('id, name').where(name: '老年').first
    when '健康管理'
      video_category = VideoCategory.select('id, name').where(name: '常识').first
    when '天天护理'
      video_category = VideoCategory.select('id, name').where(name: '美容').first
    when '寻医'
      video_category = VideoCategory.select('id, name').where(name: '医疗').first
    when '母婴'
      video_category = VideoCategory.select('id, name').where(name: '儿科').first
    when '两性健康'
      video_category = VideoCategory.select('id, name').where(name: '两性').first
    when '健身减肥'
      video_category = VideoCategory.select('id, name').where(name: '健身').first
    else
      video_category = ''
    end

  end

  def top_videos
    # 头条对资讯  养生对养生  长寿对老年 美食没有 健康管理对常识  天天护理对整形  寻医对中医 用药对医疗 母婴对儿科 海外没有 两性健康对两性 健身减肥对健身
    case self.name
    when '头条'
      video_category = VideoCategory.where(name: '资讯').first
    when '养生'
      video_category = VideoCategory.where(name: '养生').first
    when '长寿'
      video_category = VideoCategory.where(name: '老年').first
    when '健康管理'
      video_category = VideoCategory.where(name: '常识').first
    when '天天护理'
      video_category = VideoCategory.where(name: '美容').first
    when '寻医'
      video_category = VideoCategory.where(name: '医疗').first
    when '母婴'
      video_category = VideoCategory.where(name: '儿科').first
    when '两性健康'
      video_category = VideoCategory.where(name: '两性').first
    when '健身减肥'
      video_category = VideoCategory.where(name: '健身').first
    else
      video_category = ''
    end

    if video_category.present?
      Video.select('id, album_name, pic_url, tv_id, time_length, html5_play_url, create_time, video_category_id').where(video_category_id: video_category.id).order("create_time desc").limit(2)
    else
      {}
    end
  end

end
