class FavoritesAPI < Grape::API

  get :favorites do
    present! apply_scopes!(current_user.favorites.includes(:item)).map(&:item), 
      with: PolymorphicEntity,
      meta: { title: "我的收藏" }
  end

  namespace :favorites do
    post :"hospital/:id" do
      current_user.add_favorite_item Hospitals::Hospital.find(params[:id])
    end
  end

  get :related do
    present [], with: PolymorphicEntity
  end

end