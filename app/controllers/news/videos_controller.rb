class News::VideosController < NewsController
  before_action :set_video_category, only: [:index, :show]
  before_action :set_video, only: [:show]
  
  def index
    @videos = @video_category.videos.where.not(swf: nil).order("created_at desc").page(params[:page]).per(5)
  end

  def show
    
  end

  private
    def set_video_category
      @video_category = VideoCategory.find(params[:video_category_id])
    end

    def set_video
      @video = @video_category.videos.find(params[:id])
    end
end

