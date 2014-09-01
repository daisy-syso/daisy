Rails.application.routes.draw do
  devise_for :accounts,
    controllers: {
      omniauth_callbacks: "accounts/omniauth_callbacks"
    }

  # Mobile JSON API
  mount DaisyAPI => '/api'

  root to: "home#index"

end
