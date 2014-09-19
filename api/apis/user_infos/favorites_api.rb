class UserInfos::FavoritesAPI < Grape::API

  namespace :favorites do

    get do
      present! apply_scopes!(current_user!.favorites.includes(:item)).map(&:item), 
        with: PolymorphicEntity,
        meta: { title: "我的收藏" }
    end

    post :"(*:type_and_id)", anchor: false do
      match = env["PATH_INFO"].match(/(?<type>.*)\/(?<id>[^\/.?]+)/)
      klass = match[:type].classify.constantize
      current_user!.add_favorite! klass.find(match[:id])
      present :info, "成功加入收藏"
    end

  end
end
