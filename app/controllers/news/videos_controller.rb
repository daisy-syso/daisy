class News::VideosController < NewsController
  before_action :set_video_category, only: [:index, :show, :more_videos]
  before_action :set_video, only: [:show]
  
  def index
    @videos = @video_category.videos.where.not(swf: nil).order("created_at desc").page(params[:page]).per(8)
  end

  def more_videos
    videos = @video_category.videos.where.not(swf: nil).order("created_at desc").page(params[:page]).per(8)

    tmp = ""

    videos.each do |video|
      tmp += "<div class='video'>
        <div class='video-content'>
          <a href='/video_category/#{@video_category.id}/videos/#{video.id}'>
            <img src='#{video.pic_url}' class='information-image'>
          </a>
        </div>
        <div class='video-detail'>
          <h4 class='album-name'>#{video.album_name}</h4>
          <p class='time-about'>
            <span class='spent-time'>
              时长: #{video.time_length/60}:#{video.time_length%60}
            </span>
            <span class='create-time'>
              发布时间: #{video.create_time.strftime("%F")}
            </span>
          </p>
        </div>
      </div>"
    end
    
    render :text => tmp
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

