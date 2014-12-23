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
    relateds_onsale = []
    3.times do |i|
      relateds_onsale << Hospitals::HospitalOnsale.offset(Random.rand(related_resources_count(Hospitals::HospitalOnsale))).first
    end
    relateds = relateds_onsale.map{|related_onsale| related_onsale.hospital }
    present! relateds, with: Hospitals::HospitalEntity, hospital_onsales_no_type_id: true
  end

end