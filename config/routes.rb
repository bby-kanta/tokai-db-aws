Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :videos
  root 'videos#index'

  resources :people do
    resources :tags,only: [:create]
    resources :penalties,only: [:create]
  end

  resources :penalties

  resources :tags

  resources :places

  resources :musics
  
end
