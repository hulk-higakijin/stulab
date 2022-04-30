Rails.application.routes.draw do
  resources :books do
    resources :chapters, except: :index
  end
end
