class DaisyAPI < Grape::API
  format :json

  rescue_from :all, :backtrace => true
  error_formatter :json, ErrorFormatter

  helpers GrapeHelper

  mount AccountsAPI
  mount FavoritesAPI
  mount FiltersAPI
  mount PriceSearchAPI

  namespace :hospitals do
    mount Hospitals::HospitalsAPI
    mount Hospitals::DoctorsAPI
    mount Hospitals::NursingRoomsAPI
    mount Hospitals::ExaminationsAPI
    mount Hospitals::TopSpecialistsAPI
  end

  namespace :drugs do
    mount Drugs::DrugsAPI
    mount Drugs::DrugstoresAPI
    mount Drugs::DiseasesAPI
  end

  namespace :social_securities do
    mount SocialSecurities::SocialSecuritiesAPI
  end

  mount NetInfos::HotSearchKeywordsAPI

  get :config do
    AppConfig
  end

  route :any, '*path' do
    not_found!
  end

end
