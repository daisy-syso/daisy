class Informations::AppInforsAPI < ApplicationAPI

  namespace :apps do
    get do
      apps = Informations::AppInformationType.all
      # present :tpl,
      present! apps, width: Informations::AppInformationTypeEntity
    end

    get ":id" do
      infor_type = Informations::HealthInformationType.where(id: params[:id]).first
      infors = infor_type.health_informations
      present :infor_type, infor_type
      present :infors, infors
    end
  end

end