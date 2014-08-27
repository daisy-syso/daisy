Rails.application.routes.draw do
  devise_for :accounts

  # Mobile JSON API
  mount DaisyAPI => '/api'

  root to: "home#index"

end
