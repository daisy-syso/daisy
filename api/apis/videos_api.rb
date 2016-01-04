class VideosAPI < Grape::API

  get 'video_categories' do
    @video_categories = VideoCategory.all
    present @video_categories, root: 'data', with: ::VideoCategoryEntity
  end

  params do
    requires :video_category_id, type: Integer
    optional :page, type: Integer
    optional :per, type: Integer
  end
  get 'videos' do
    @videos = Video.where(video_category_id: params.video_category_id).order("create_time desc").page(params[:page]).per(params[:per])
    present @videos, root: 'data', with: ::VideoEntity
  end
end