Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  root to: 'user#index'
  get '/search', to: 'search#index', as: :search

  namespace :api do
  	namespace :v1 do
      get 'users/deck_statistics', to: 'users#deck_statistics'
  		resources :users, only: [:index, :show]
  	end
  end
end
