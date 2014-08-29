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
  helpers do
    def related_resources_count klass
      Rails.cache.fetch([:api, :related, klass.name, :count]) do
        klass.count
      end
    end
  end
  get :related do
    relateds = (RelatedClasses * 3).sample(3).map do |klass|
      klass.offset(Random.rand(related_resources_count(klass))).first
    end
    present! relateds, with: PolymorphicEntity
  end

end