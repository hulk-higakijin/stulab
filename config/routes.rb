Rails.application.routes.draw do
  devise_for :users
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  root 'home#index'
  resources :books do
    resources :chapters, except: :index
    resources :reviews, only: %i[ index create destroy ]
  end
end
