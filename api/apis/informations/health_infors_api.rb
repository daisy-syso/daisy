class Informations::HealthInforsAPI < ApplicationAPI

  namespace :nav do
    get do
      navs = Informations::HealthInformationType.all.includes(:health_informations)
      # present :tpl,
      present navs, with: Informations::HealthInformationTypeEntity
    end

    get ":id" do
      infor_type = Informations::HealthInformationType.where(id: params[:id]).first
      infors = infor_type.health_informations
      present :infor_type, infor_type
      present :infors, infors
    end
  end

  namespace :health_infors do
    get do
      information_type_id = params[:type] || 1
      @informations = Informations::HealthInformation.where(type_id: information_type_id).page(params[:page])
      present title: "健康资讯"
      present :information_types, Informations::HealthInformationType.where(parent_id: [nil, '']), with: Informations::HealthInformationTypeEntity
      present :data, @informations, with: Informations::HealthInformationEntity
    end

    show! Informations::HealthInformation
  end

end