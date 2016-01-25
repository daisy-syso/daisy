# encoding: utf-8
class News::InformationController < NewsController
  before_action :set_information, only: [:show, :comment]

  def comment
    arr = []
    File.open(File.expand_path('../../../../db/alias_name.txt', __FILE__)) do |file|
      file.each do |row|
        arr << row.strip
      end
    end

    alias_name = arr.sample

    comment = @information.information_comments.new(content: params[:content], alias_name: alias_name)
    if comment.save
      redirect_to news_information_path(@information)
    end
  end

  def index
    @information_types = Informations::InformationType.select("id, name, parent_id, top_number").where(parent_id: nil).order("created_at desc")

    @information_hotest_images = Informations::Information.select('id, name, image_url').unscope(:where).where(types: 7).order("created_at desc").limit(2)

    @precise_queries = PreciseQuery.all

    @infors = Informations::Information.where(is_top: true).where.not(image_url: nil).order("str_to_date(created_at,'%Y-%m-%d %H:%i:%s') desc").limit(4)

    @apps = Informations::AppInformation.group(:type_id).order(:type_id).first(5)

    @information_lists = []

    @information_types.each do |it|
      parent_id = it.parent_id || it.id
      pageset = (it.name == '头条' || it.name == '天天护理') ? 12 : 8
      top_infors = "(select * from informations where information_type_id = #{parent_id} and is_top is true and types = 0 order by str_to_date(created_at,'%Y-%m-%d %H:%i:%s') desc limit #{it.top_number})"
      if it.parent_id.blank?
        ids = it.children_items.map(&:id) + [it.id]
        select_infos = "(select * from informations where information_type_id in (#{ids.join(',')}) and is_top is not true and types = 0"
      else
        part_infors = "(select * from informations where information_type_id = #{it.id} and is_top is not true and types = 0)"
        ids = (it.parent_item.children_items.map(&:id) + [it.parent_item.id]).delete_if{|i| i == it.id}
        select_infos = part_infors + " union " + "(select * from informations where information_type_id in (#{ids.join(',')}) and is_top is not true and types = 0"
      end
      info_sql = top_infors + " union " + select_infos + " order by str_to_date(created_at,'%Y-%m-%d %H:%i:%s') desc limit #{pageset} offset #{((params[:page] || 1).to_i - 1) * pageset})"

      # Informations::Information.where().order("created_at desc").page(params[:page]).per(per)
      it.latest_informations = Informations::Information.unscope(:where).find_by_sql(info_sql)

      video_category2 = case it.name
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

      top_video = if video_category.present?
        Video.select('id, album_name, pic_url, tv_id, time_length, html5_play_url, create_time, video_category_id').where(video_category_id: video_category.id).order("create_time desc").limit(2)
      else
        {}
      end

      types_image = case it.name
      when '头条'
        Informations::Information.select('id, name, image_url').unscope(:where).where(types: 5).order("created_at desc").limit(2)
      when '天天护理'
        Informations::Information.select('id, name, image_url').unscope(:where).where(types: 6).order("created_at desc").limit(2)
      end

      @information_lists << {
        id: it.id,
        name: it.name,
        informations: it.latest_informations,
        sub_types: it.children_items,
        top_videos: top_video,
        video_category: video_category2,
        types_images: types_image
      }
    end
  end

  def more_information
    name = params[:name] || '头条' 
    it = Informations::InformationType.where(name: name).first

    per = (it.name == '头条' || it.name == '天天护理') ? 12 : 8
    page = params[:page] || 2

    informations = Informations::Information.unscope(:where).where(types: 0, is_top: false, information_type_id: it.id).order("created_at desc").page(page).per(per)

    results = []

    informations.each do |i|
      results << {
        id: i.id,
        name: i.name
      }
    end

    render :json =>  {
      data: results, 
      current_page: informations.current_page,
      last_page: informations.last_page?,
      next_page: informations.next_page
    }.to_json
  end

  def information_list
    @information = Diseases::DiseaseInfo.where(disease_info_type_id: params[:disease_info_type_id]).all
  end

  def show
    @guess_infos = Informations::Information.guessed.order("str_to_date(created_at,'%Y-%m-%d %H:%i:%s') desc").limit(12)

    @recommended_infos = Informations::Information.unscope(:where).select('id, name').where.not(id: params[:id]).order("str_to_date(created_at,'%Y-%m-%d %H:%i:%s') desc").limit(8)

    @hot_images = Informations::Information.unscope(:where).select('id, name, image_url').where.not(id: params[:id], image_url: nil).order("str_to_date(created_at,'%Y-%m-%d %H:%i:%s') desc").limit(8)

    @comments = @information.information_comments.all.order("created_at desc").page(1).per(5)
  end

  private
    def set_information
      @information = Informations::Information.find(params[:id])
    end
end
