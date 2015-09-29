class Informations::HealthInforsAPI < ApplicationAPI

  namespace :health_infors do
    get do
      information_types = Informations::InformationType.select("id, name").where(parent_id: [nil, ''])
      information_type = Informations::InformationType.where(id: params[:type]) if params[:type]
      information_type ||= information_types
      present title: "健康资讯"
      present information_types: information_types
      present :data, information_type, with: Informations::InformationTypeEntity
    end

    show! Informations::Information
  end

end