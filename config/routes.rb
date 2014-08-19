Rails.application.routes.draw do
  devise_for :accounts

  # Mobile JSON API
  mount DaisyAPI => '/api'

end
