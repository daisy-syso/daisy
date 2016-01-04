namespace :videos do
  desc "定时添加视频"
  task :schadd => :environment do
    # 健康
    categoryId = "32"

    apiKey = "eefa2897acae4ebf998c6695740a954c"

    startTime = (Time.now - 3.hours).strftime("%F%T").gsub("-","").gsub(":","").to_s
    endTime = Time.now.strftime("%F%T").gsub("-","").gsub(":","").to_s

    sch_add_url = "http://expand.video.iqiyi.com/api/album/udlist.json?apiKey=#{apiKey}&startTime=#{startTime}&endTime=#{endTime}&categoryId=#{categoryId}&status=1"

    conn = Faraday.new(:url => sch_add_url) do |faraday|
      faraday.request  :url_encoded
      faraday.response :logger
      faraday.adapter  Faraday.default_adapter
    end

    response = conn.get
    response.body

    debugger

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