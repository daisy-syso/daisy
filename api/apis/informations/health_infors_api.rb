class Informations::HealthInforsAPI < ApplicationAPI

  namespace :health_infors do
    get do
      information_types = Informations::InformationType.select("id, name, parent_id, top_number").where(parent_id: nil).order("created_at desc")
      information_type = params[:type].blank? ? information_types : Informations::InformationType.where(id: params[:type])
      information_type.each do |it|
        parent_id = it.parent_id || it.id
        pageset = (it.name == '头条' || it.name == '天天护理') ? 12 : 8
        top_infors = "(select *, 1 as rank from informations where information_type_id = #{parent_id} and is_top is true and types = 0 order by str_to_date(created_at,'%Y-%m-%d %H:%i:%s') desc limit #{it.top_number})"
        if it.parent_id.blank?
          ids = it.children_items.map(&:id) + [it.id]
          select_infos = "(select *, 2 as rank from informations where information_type_id in (#{ids.join(',')}) and is_top is not true and types = 0)"
        else
          part_infors = "(select *, 3 as rank from informations where information_type_id = #{it.id} and is_top is not true and types = 0)"
          ids = (it.parent_item.children_items.map(&:id) + [it.parent_item.id]).delete_if{|i| i == it.id}
          select_infos = part_infors + " union " + "(select *, 4 as rank from informations where information_type_id in (#{ids.join(',')}) and is_top is not true and types = 0)"
        end
        info_sql = "select * from ( " + top_infors + " union " + select_infos + " ) as infors order by rank asc, str_to_date(infors.created_at,'%Y-%m-%d %H:%i:%s') desc limit #{pageset} offset #{((params[:page] || 1).to_i - 1) * pageset}"
        it.latest_informations = Informations::Information.unscope(:where).find_by_sql(info_sql)
      end
      present title: "健康资讯"
      present information_types: information_types
      present :data, information_type, with: Informations::InformationTypeEntity
    end

    show! Informations::Information

    get ":id/read" do
      information =  Informations::Information.unscope(:where).find(params[:id])
      information.update_attributes(read_count: (information.read_count.to_i + 1))
      status 201
    end
  end

  namespace :hot do
    get do
      infors = Informations::Information.where(is_top: true).where.not(image_url: nil).order("str_to_date(created_at,'%Y-%m-%d %H:%i:%s') desc").limit(4)
      present :data, infors, with: Informations::InformationEntity
    end

    get 'guessed' do
      infos = Informations::Information.guessed.order("str_to_date(created_at,'%Y-%m-%d %H:%i:%s') desc").limit(12)
      present :data, infos, with: Informations::InformationEntity
    end

    get 'recommended' do
      infos = Informations::Information.recommended.order("str_to_date(created_at,'%Y-%m-%d %H:%i:%s') desc").limit(12)
      present :data, infos, with: Informations::InformationEntity
    end

    get 'selected' do
      infos = Informations::Information.selected.order("str_to_date(created_at,'%Y-%m-%d %H:%i:%s') desc").limit(12)
      present :data, infos, with: Informations::InformationEntity
    end
  end

end