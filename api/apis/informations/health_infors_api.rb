class Informations::HealthInforsAPI < ApplicationAPI

  namespace :nav do
    get do
      navs = Informations::HealthInformationType.all
      # present :tpl,
      present navs
    end

    get ":id" do
      infor_type = Informations::HealthInformationType.where(id: params[:id]).first
      infors = infor_type.health_informations
      present :infor_type, infor_type
      present :infors, infors
    end
  end

end