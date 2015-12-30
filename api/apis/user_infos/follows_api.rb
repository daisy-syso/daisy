# 关注
class UserInfos::FollowsAPI < Grape::API
  namespace :follows do
    get do
      current_user!

      follows = current_user!.follows

      present follows
    end

    desc '添加关注'
    post do
      current_user!
      
      present :info, "关注成功"
    end

  end
end
