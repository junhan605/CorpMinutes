Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  resources :companies
  root to: 'visitors#index'
  devise_for :users
  resources :users
end
