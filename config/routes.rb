Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users
  root 'home#index'
  resources :books do
    resources :chapters, except: :index
    resources :reviews, only: %i[ index create destroy ]
  end
  resources :profile, only: [:index]
end
