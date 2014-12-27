class RelatedResourcesAPI < Grape::API

  RelatedClasses = [Drugs::Drug, Drugs::Drugstore, Hospitals::Hospital]
  helpers do
    def related_resources_count klass
      Rails.cache.fetch([:api, :related, klass.name, :count]) do
        klass.count
      end
    end

    def hospital_type_id hospital_type_name
      { '男科医院' => 1,
        '整形医院' => 2,
        '体检医院' => 3,
        '中医医院' => 4,
        '妇幼医院' => 5,
        '牙科医院' => 6,
        }[hospital_type_name]
    end
  end
  get :related do
    relateds = (RelatedClasses * 3).sample(3).map do |klass|
      klass.offset(Random.rand(related_resources_count(klass))).first
    end
    present! relateds, with: PolymorphicEntity
  end

  get :related_hospital do
    id = hospital_type_id params[:hospital_type]
    a = Hospitals::HospitalOnsale.all.map {|a| a.hospital_id}.compact
    b = Hospitals::HospitalType.find(id).hospitals.map {|h| h.id}.compact
    p "==========#{a & b}"
    c = a & b

    # 3.times do |i|
    #   relateds_onsale << Hospitals::HospitalOnsale.offset(Random.rand(related_resources_count(Hospitals::HospitalOnsale))).first
    # end
    # relateds = relateds_onsale.map{|related_onsale| related_onsale.hospital }
    relateds = []
    3.times do |i|
      random_number = Random.rand(c.count)
      relateds << Hospitals::Hospital.where(id: c[random_number]).first
    end
    p relateds
    present! relateds , with: Hospitals::HospitalEntity, hospital_onsales_no_type_id: true
  end

end