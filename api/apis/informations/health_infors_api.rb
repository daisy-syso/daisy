class Informations::HealthInforsAPI < ApplicationAPI

  namespace :health_infors do
    get do
      information_types = Informations::InformationType.select("id, name, parent_id").where(parent_id: [nil, '']).order("created_at desc")
      information_type = Informations::InformationType.where(id: params[:type]) if params[:type]
      Informations::Information.update_all(updated_at: DateTime.now, information_type_id: params[:type]) if params[:type]
      information_type ||= information_types
      information_type.each do |it|
        it_ids = it.parent_id.blank? ? (it.children_items.map(&:id) + [it.id]) : (it.parent_item.children_items.map(&:id) + [it.parent_item.id])
        order_str = it.parent_id.blank? ? "is_top desc, str_to_date(created_at,'%Y-%m-%d %H:%i:%s') desc" : "is_top desc, updated_at desc, str_to_date(created_at,'%Y-%m-%d %H:%i:%s') desc"
        it.latest_informations = Informations::Information.where(information_type_id: it_ids).order(order_str).page(params[:page]).per(8)
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

end