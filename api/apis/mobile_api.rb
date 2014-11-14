class MobileAPI < ApplicationAPI

  namespace :mobile do
    params do
      optional :alphabet
    end
    get :drugs do
      content_type "application/json; charset=UTF-8"
      drugs = Drugs::Drug.all
      drugs = drugs.alphabet(params[:alphabet]) if params[:alphabet]
      present data: drugs.limit(100).pluck(:name)
    end
  end

end