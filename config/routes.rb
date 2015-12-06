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

  resources :editors do
    get 'drugstores'
    get 'drugs'
  end

  # resources :e_drugs

  resources :e_drugstores do
    resources :incidents
    resources :e_drugs
  end

  resources :editors_session do
    collection do
      get 'login'
      get 'logout'
    end
  end

  resources :drugs_drugs

  resources :drugs_drugstores

  constraints :subdomain => /^(stores(.*))$/i  do
    namespace :stores, path: '/:store_name' do
      root 'stores#index'
      get 'incident/:id', to: 'stores#incident'
    end
  end

end
