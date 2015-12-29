# 关注
class UserInfos::FollowsAPI < Grape::API
  namespace :follows do
    get do
      current_user

      follows = current_user!.follows

      present follows
    end

    post :"(*:type_and_id)", anchor: false do
      match = env["PATH_INFO"].match(/(?<type>.*)\/(?<id>[^\/.?]+)/)
      klass = match[:type].classify.constantize
      current_user!.add_favorite! klass.find(match[:id])
      present :info, "成功加入收藏"
    end

  end
end
