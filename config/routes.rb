Rails.application.routes.draw do
  devise_for :users
  # Mobile JSON API
  mount DaisyAPI => '/api'

end
