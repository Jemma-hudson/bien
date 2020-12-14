Rails.application.routes.draw do
  ActiveAdmin.routes(self)
  resources :reviews do
    resources :comments
    resource :bookmark
  end
  root "pages#home"

  resource :session
  resources :users

  get "about", to: "pages#about"
  get "terms", to: "pages#terms"


end
