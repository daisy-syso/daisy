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
            begin
              video_old = Video.where(album_name: video["albumName"]).first
              unless video_old
                uuid = SecureRandom.uuid
                path = File.join('/tmp', 'tmp.jpg')

                if video["picUrl"].present?
                  File.open(path, "wb") { |f| f.write(URI.parse(video["picUrl"]).read) }
                end

                a,b,c = Qiniu::Storage.upload_with_put_policy(
                  $put_policy,     # 上传策略
                  path,     # 本地文件名
                  uuid,            # 最终资源名，可省略，缺省为上传策略 scope 字段中指定的Key值
                )

                Video.find_or_create_by(
                  album_name: video["albumName"],
                  pic_url: "http://7d9otw.com1.z0.glb.clouddn.com/#{uuid}",
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
            rescue Exception => e
              puts e
            end
          end
        end
      end
    end
  end
end