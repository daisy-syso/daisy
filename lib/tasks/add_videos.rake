namespace :videos do
  desc "添加视频"
  task :add => :environment do
    category_list_url = 'http://expand.video.iqiyi.com/api/category/list.json?apiKey=eefa2897acae4ebf998c6695740a954c'

    # 健康
    categoryId = "32"

    apiKey = "eefa2897acae4ebf998c6695740a954c"
    (1..340).each do |pageNo|
      vides_url = "http://expand.video.iqiyi.com/api/album/list.json?apiKey=#{apiKey}&categoryId=#{categoryId}&pageNo=#{pageNo}"

      conn = Faraday.new(:url => vides_url) do |faraday|
        faraday.request  :url_encoded
        faraday.response :logger
        faraday.adapter  Faraday.default_adapter
      end

      response = conn.get
      response.body

      data = Oj.load(response.body)["data"]

      data.each do |video|
        if video["threeCtgs"].present?
          video_category = data.last["threeCtgs"].first["name"]
          video_category = VideoCategory.where(name: video_category).first

          if video_category.present?
            Video.find_or_create_by(
              album_name: video["albumName"],
              pic_url: video["picUrl"],
              play_url: video["playUrl"],
              tv_id: video["tvIds"].first,
              create_time: video["createdTime"],
              time_length: video["timeLength"],
              sub_title: video["subTitle"],
              html5_url: video["html5Url"],
              html5_play_url: video["html5PlayUrl"],
              video_category_id: video_category.id
              )
          end
        end
      end
    end
  end
end