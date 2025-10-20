# config/routes.rb
require "devise"

Rails.application.routes.draw do
  # Devise routes for user authentication
  devise_for :users

  # Recipe routes
  resources :recipes

  # Root route
  root "recipes#index"
end
