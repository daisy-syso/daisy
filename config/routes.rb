Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :accounts,
    controllers: {
      omniauth_callbacks: "accounts/omniauth_callbacks"
    }

  # Mobile JSON API
  mount DaisyAPI => '/api'

  get "/mobiles" => redirect("/mobiles/index.html")

  # root to: "home#index"

  root 'editors_session#login'

  resources :editors

  resources :editors_session do
    collection do
      get 'login'
      get 'logout'
    end
  end

  resources :drugs_drugs

  resources :drugs_drugstores


  # constraints :subdomain => /^(stores(.*))$/i  do
  #   namespace :stores, path: '/' do
  #     root 'main#index'
  #   end
  # end

end
