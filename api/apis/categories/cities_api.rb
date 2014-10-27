class Categories::CitiesAPI < ApplicationAPI

  namespace :cities do
    filter! Categories::City
  end
  
end