class RelatedResourcesAPI < Grape::API

  RelatedClasses = [Drugs::Drug, Drugs::Drugstore, Hospitals::Hospital]
  helpers do
    def related_resources_count klass
      Rails.cache.fetch([:api, :related, klass.name, :count]) do
        klass.all.count
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
    # relateds = (RelatedClasses * 20).sample(20).map do |klass|
    #   klass = klass.all.has_url if klass == Hospitals::Hospital
    #   begin 
    #     related = klass.offset(Random.rand(related_resources_count(klass))).first
    #   end while related.nil?
    #   # t = klass.all.offset(Random.rand(related_resources_count(klass))).first
    #   related
    # end
    counts = {}
    counts.default = 0
    relateds = (RelatedClasses * 20).sample(20).map do |klass|
      collects = klass.all
      collects = klass.all.has_url if klass == Hospitals::Hospital
      related = collects.extension(1).limit(1).offset(counts[klass.to_s]).first
      counts[klass.to_s] += 1
      related
    end

    present! relateds, with: PolymorphicEntity
  end

  # get :related_hospital do
  #   id = hospital_type_id params[:hospital_type]
  #   a = Hospitals::HospitalOnsale.all.map {|a| a.hospital_id}.compact
  #   b = Hospitals::HospitalType.find(id).hospitals.map {|h| h.id}.compact
  #   p "==========#{a & b}"
  #   c = a & b

  #   # 3.times do |i|
  #   #   relateds_onsale << Hospitals::HospitalOnsale.offset(Random.rand(related_resources_count(Hospitals::HospitalOnsale))).first
  #   # end
  #   # relateds = relateds_onsale.map{|related_onsale| related_onsale.hospital }
  #   relateds = []
  #   3.times do |i|
  #     random_number = Random.rand(c.count)
  #     relateds << Hospitals::Hospital.where(id: c[random_number]).first
  #   end
  #   p relateds
  #   present! relateds , with: Hospitals::HospitalEntity, hospital_onsales_no_type_id: true
  # end

  get :related_hospital do
    id = hospital_type_id params[:hospital_type]
    hospital_charges = Hospitals::HospitalCharge.where(hospital_type_parent_id: id)
    if params[:only_onsales]
      hospital_charges = Hospitals::HospitalCharge.where(hospital_type_id: params[:only_onsales])
    end
    if !hospital_charges.blank?
      relateds = []
      20.times do |i|
        releted_charge = hospital_charges.to_a.delete_at(Random.rand(hospital_charges.count))
        related_onsales = releted_charge.try(:hospital_onsales)
        relateds << related_onsales.offset(Random.rand(related_onsales.count)).first.hospital if !related_onsales.blank?
      end
    end
    present! relateds || [] , with: Hospitals::HospitalEntity, hospital_onsales_no_type_id: true
  end


end