class DaisyAPI < Grape::API
  format :json

  rescue_from :all, :backtrace => true
  error_formatter :json, ErrorFormatter
  
  # before do
  #   error!("401 Unauthorized", 401) unless authenticated
  # end

  helpers GrapeHelper

  mount Hospitals::HospitalAPI

end