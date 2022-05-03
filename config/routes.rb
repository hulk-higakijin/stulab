Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  root 'home#index'
  resources :books do
    resources :chapters, except: :index
  end
  devise_for :users
end
