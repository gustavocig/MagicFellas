Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  root to: 'users#index'

  get '/settings', to: 'users#settings', as: :settings
  get '/search', to: 'cards#search', as: :cards_search
  get '/cards', to: 'cards#index', as: :cards_index
  get '/remove_from_deck', to: 'cards#remove_from_deck', as: :card_remove
  get '/add_to_deck', to: 'cards#add_to_deck', as: :card_add

  resources :decks
  resources :users

  namespace :api do
  	namespace :v1 do
      get 'users/deck_statistics', to: 'users#deck_statistics'
  		resources :users, only: [:index, :show]
  	end
  end
end
