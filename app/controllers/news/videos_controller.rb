class News::VideosController < NewsController
  before_action :set_video_category, only: [:index]
  
  def index
    @videos = @video_category.videos.where.not(swf: nil).order("created_at desc").page(params[:page]).per(5)
  end

  def show
    
  end

  private
    def set_video_category
      @video_category = VideoCategory.find(params[:video_category_id])
    end
end
