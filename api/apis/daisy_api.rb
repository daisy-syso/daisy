class DaisyAPI < Grape::API
  format :json

  rescue_from :all, :backtrace => true
  error_formatter :json, ErrorFormatter

  helpers GrapeHelper

  mount AccountsAPI
  mount FavoritesAPI
  mount FiltersAPI

  mount Hospitals::HospitalsAPI
  mount Hospitals::DoctorsAPI

  mount Drugs::DrugsAPI
  
  mount NetInfos::HotSearchKeywordsAPI

  route :any, '*path' do
    not_found!
  end

end