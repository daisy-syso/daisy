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

end