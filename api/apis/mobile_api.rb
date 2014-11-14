class MobileAPI < ApplicationAPI

  namespace :mobile do
    params do
      optional :alphabet
    end
    get :drugs do
      drugs = Drugs::Drug.all
      drugs = drugs.alphabet(params[:alphabet]) if params[:alphabet]
      present drugs.pluck(:name)
    end
  end

end