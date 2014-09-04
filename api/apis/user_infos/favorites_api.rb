class UserInfos::FavoritesAPI < Grape::API

  namespace :favorites do

    get do
      present! apply_scopes!(current_user!.favorites.includes(:item)).map(&:item), 
        with: PolymorphicEntity,
        meta: { title: "我的收藏" }
    end

    namespace :hospitals do
      post :"hospitals/:id" do
        current_user!.add_favorite! Hospitals::Hospital.find(params[:id])
        present :info, "成功加入收藏"
      end
    end

    namespace :drugs do
      post :"drugs/:id" do
        current_user!.add_favorite! Drugs::Drug.find(params[:id])
        present :info, "成功加入收藏"
      end
    end

  end
end
