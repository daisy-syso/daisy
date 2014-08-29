class FavoritesAPI < Grape::API

  namespace :favorites do

    get do
      present! apply_scopes!(current_user.favorites.includes(:item)).map(&:item), 
        with: PolymorphicEntity,
        meta: { title: "我的收藏" }
    end

    namespace :hospitals do
      post :"hospitals/:id" do
        current_user.add_favorite_item Hospitals::Hospital.find(params[:id])
      end
    end

  end

  RelatedClasses = [Drugs::Drug, Drugs::Drugstore, Hospitals::Hospital]
  get :related do
    relateds = (RelatedClasses * 3).sample(3).map do |klass|
      klass.uncached do
        klass.order("RAND()").first
      end
    end
    present! relateds, with: PolymorphicEntity
  end

end