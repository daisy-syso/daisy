class RelatedResourcesAPI < Grape::API

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

  get :related_hospital do
    relateds = []
    3.times do |i|
      relateds << Hospitals::Hospital.offset(Random.rand(related_resources_count(Hospitals::Hospital))).first
    end
    present! relateds, with: PolymorphicEntity
  end

end