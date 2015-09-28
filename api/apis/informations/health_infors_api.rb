class Informations::HealthInforsAPI < ApplicationAPI

  namespace :health_infors do
    get do
      information_type_id = params[:type] || 1
      @informations = Informations::Information.where(information_type_id: information_type_id).order("str_to_date(created_at,'%Y-%m-%d %H:%i:%s') desc").page(params[:page])
      present title: "健康资讯"
      present :information_types, Informations::InformationType.where(parent_id: [nil, '']), with: Informations::InformationTypeEntity
      present :data, @informations, with: Informations::InformationEntity
    end

    show! Informations::Information
  end

end