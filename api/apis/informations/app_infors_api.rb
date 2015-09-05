class Informations::AppInforsAPI < ApplicationAPI

  namespace :apps do
    get do
      apps = Informations::AppInformationType.all
      # present :tpl,
      present! apps, width: Informations::AppInformationTypeEntity
    end

    desc "获取前四个"
    get "examples" do 
      present :apps, Informations::AppInformation.group(:type_id).order(:type_id).first(5)
    end

    get ":id" do
      app_type = Informations::AppInformationType.where(id: params[:id]).first
      apps = app_type.app_informations
      present :app_type, app_type
      present :apps, apps
    end


  end

end