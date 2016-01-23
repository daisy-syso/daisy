Rails.application.routes.draw do
  

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  # constraints :host => 'www.jiankanghj.com' do
    namespace :news, path: '/' do

      resources :information do
        collection do
          get 'more_information'
        end
        

        member do
          post 'comment'
        end
      end

      get '/information_list', to: "information#information_list"

      resources :video_category do
        resources :videos
      end
      
      get '/', to: "information#index"

      get '/accounts/mine', to: "accounts#mine"

      get '/accounts/follow', to: "accounts#follow"
      get '/accounts/delete_follow', to: "accounts#delete_follow"

      get '/accounts/following_list', to: "accounts#following_list"

      devise_for :accounts, controllers: { sessions: "accounts/sessions", registrations: "accounts/registrations", passwords: "accounts/passwords", confirmations: "accounts/confirmations" }

    end
  # end

  # devise_for :accounts,
  #   controllers: {
  #     omniauth_callbacks: "accounts/omniauth_callbacks"
  #   }

  # Mobile JSON API
  mount DaisyAPI => '/api'

  get "/mobiles" => redirect("/mobiles/index.html")

  constraints :host => 'www.yiliaohj.com' do
    root 'editors_session#login'

    resources :editors do
      get 'drugstores'
      get 'drugs'
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
  end

  constraints :subdomain => /^(stores(.*))$/i  do
    namespace :stores, path: '/:store_name' do
      root 'stores#index'
      get 'incident/:id', to: 'stores#incident'
      get 'get_more_feedback', to: 'stores#get_more_feedback'
      get 'feedbacks/new', to: 'feedbacks#new'
      post 'feedbacks', to: 'feedbacks#create'

      resources :drugtypes do
        member do
          get 'drugs'
          get 'sub_drugs'
          get 'subsub_drugs'
        end
      end
      resources :e_drugs
    end
  end

end
