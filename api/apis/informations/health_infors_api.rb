class Informations::HealthInforsAPI < ApplicationAPI

  namespace :health_infors do
    get do
      information_types = Informations::InformationType.select("id, name").where(parent_id: [nil, ''])
      information_type = Informations::InformationType.where(id: params[:type]) if params[:type]
      information_type ||= information_types
      information_type.each do |it|
        it.latest_informations = it.informations.order("str_to_date(created_at,'%Y-%m-%d %H:%i:%s') desc").page(params[:page]).per(8)
      end
      present title: "健康资讯"
      present information_types: information_types
      present :data, information_type, with: Informations::InformationTypeEntity
    end

    show! Informations::Information
  end

end