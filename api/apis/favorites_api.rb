class FavoritesAPI < Grape::API

  namespace :favorites do

    get do
      present! apply_scopes!(current_user.favorites.includes(:item)).map(&:item), 
        with: PolymorphicEntity,
        meta: { title: "我的收藏" }
    end

    namespace :hospitals do
      post :"hospitals/:id" do
        current_user!.add_favorite_item Hospitals::Hospital.find(params[:id])
      end
    end

    namespace :drugs do
      post :"drugs/:id" do
        current_user!.add_favorite_item Drugs::Drug.find(params[:id])
      end
    end

  end

end