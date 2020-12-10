Rails.application.routes.draw do
  resources :reviews do
    resources :comments
    resource :bookmark
  end
  root "reviews#index"

  resource :session
  resources :users


end
