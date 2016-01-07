class News::InformationController < NewsController
  before_action :set_information, only: [:show]

  def index
    @information_types = Informations::InformationType.select("id, name, parent_id, top_number").where(parent_id: nil).order("created_at desc")

    @information_hotest_images = Informations::Information.select('id, name, image_url').unscope(:where).where(types: 7).order("created_at desc").limit(2)

    @precise_queries = PreciseQuery.all
    # @information = Informations::Information.all.limit(10)

    @infors = Informations::Information.where(is_top: true).where.not(image_url: nil).order("str_to_date(created_at,'%Y-%m-%d %H:%i:%s') desc").limit(4)
  end

  def show
    @guess_infos = Informations::Information.guessed.order("str_to_date(created_at,'%Y-%m-%d %H:%i:%s') desc").limit(12)

    @recommended_infos = Informations::Information.unscope(:where).select('id, name').where.not(id: params[:id]).order("str_to_date(created_at,'%Y-%m-%d %H:%i:%s') desc").limit(8)

    @hot_images = Informations::Information.unscope(:where).select('id, name, image_url').where.not(id: params[:id], image_url: nil).order("str_to_date(created_at,'%Y-%m-%d %H:%i:%s') desc").limit(8)
  end

  private
    def set_information
      @information = Informations::Information.find(params[:id])
    end
end
