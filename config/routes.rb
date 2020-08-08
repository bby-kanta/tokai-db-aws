Rails.application.routes.draw do

#api用
  namespace :api, {format: 'json'} do
    namespace :v1 do
      resources :videos, only: [:index, :show] do
        collection do
          get 'recommend'
        end
      end
      resources :people, only: [:index, :show] 
      resources :penalties, only: [:index, :show] 
      resources :tags, only: [:index, :show] 
      resources :musics, only: [:index, :show] 
      resources :places, only: [:index, :show] 
      resources :users
      resources :favorites, only: [:index ,:create, :destroy]
    end
  end


  get 'relationships/create'
  get 'relationships/destroy'
  devise_for :users
  resources :users, only: [:show]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :videos do
    resource :relationships,only: [:create,:destroy]
    resource :favorites,only: [:create,:destroy]
    collection do
      get 'search'
    end
  end

  root 'videos#index'

  resources :people do
    resources :tags,only: [:create]
    resources :penalties,only: [:create]
    collection do
      get 'search'
    end
  end

  resources :penalties do
    collection do
      get 'search'
    end
  end

  resources :tags do
    collection do
      get 'search'
    end
  end

  resources :places do
    collection do
      get 'search'
    end
  end

  resources :musics do
    collection do
      get 'search'
    end
  end
  
end
