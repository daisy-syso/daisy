namespace :video_categories do
  desc "视频分类"
  task :add => :environment do
    %w(资讯 医疗 两性 养生 健身 美容 心理 常识 儿科 老年 宠物 交流分享).each do |name|
      VideoCategory.find_or_create_by(name: name)
    end
  end
end