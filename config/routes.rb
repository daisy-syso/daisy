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

  constraints host: 'www.yyy.com' do
    namespace :stores, path: '/' do
      get '/' => 'articles#index'
    end
  end

  resources :e_drugstores do
    resources :feedbacks
    resources :incidents
    resources :e_drugs do
      get 'get_types'
    end
  end

  get 'get_types', to: 'e_drugs#get_types'

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
      get 'get_more_feedback', to: 'stores#get_more_feedback'
      get 'feedbacks/new', to: 'feedbacks#new'
      post 'feedbacks', to: 'feedbacks#create'

      # get 'drugtypes/:drugtype_id/drugs', to: 'drugtypes#index'

      resources :drugtypes do
        member do
          get 'drugs'
          get 'sub_drugs'
          get 'subsub_drugs'
        end
      end
      resources :e_drugs
      # get 'drugs', to: 'drugs#show'
    end
  end

  constraints :subdomain => /^((.*))$/i  do
    namespace :stores, path: '/:store_name' do
      
    end
  end
end
