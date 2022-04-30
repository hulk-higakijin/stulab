Rails.application.routes.draw do
  root 'home#index'
  resources :books do
    resources :chapters, except: :index
  end
end
