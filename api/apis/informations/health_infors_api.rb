class Informations::HealthInforsAPI < ApplicationAPI

  namespace :health_infors do
    get do
      information_types = Informations::InformationType.select("id, name, parent_id").where(parent_id: nil).order("created_at desc")
      information_type = params[:type].blank? ? information_types : Informations::InformationType.where(id: params[:type])
      information_type.each do |it|
        parent_id = it.parent_id || it.id
        top_infors = "(select * from informations where information_type_id = #{parent_id} and is_top is true order by str_to_date(created_at,'%Y-%m-%d %H:%i:%s') desc)"
        if it.parent_id.blank?
          ids = it.children_items.map(&:id) + [it.id]
          select_infos = "(select * from informations where information_type_id in (#{ids.join(',')}) and is_top is not true order by str_to_date(created_at,'%Y-%m-%d %H:%i:%s') desc)"
        else
          part_infors = "(select * from informations where information_type_id = #{it.id} and is_top is not true order by str_to_date(created_at,'%Y-%m-%d %H:%i:%s') desc)"
          ids = (it.parent_item.children_items.map(&:id) + [it.parent_item.id]).delete_if{|i| i == it.id}
          select_infos = part_infors + " union " + "(select * from informations where information_type_id in (#{ids.join(',')}) and is_top is not true order by str_to_date(created_at,'%Y-%m-%d %H:%i:%s') desc)"
        end
        info_sql = "select * from ( " + top_infors + " union " + select_infos + " ) as infors limit 8 offset #{((params[:page] || 1).to_i - 1) * 8}"
        it.latest_informations = Informations::Information.find_by_sql(info_sql)
      end
      present title: "健康资讯"
      present information_types: information_types
      present :data, information_type, with: Informations::InformationTypeEntity
    end

    show! Informations::Information

    get ":id/read" do
      information =  Informations::Information.find(params[:id])
      information.update_attributes(read_count: (information.read_count.to_i + 1))
      status 201
    end
  end

  namespace :hot do
    get do
      infors = Informations::Information.where(is_top: true).where.not(image_url: nil).order("str_to_date(created_at,'%Y-%m-%d %H:%i:%s') desc").limit(4)
      present :data, infors, with: Informations::InformationEntity
    end
  end

end