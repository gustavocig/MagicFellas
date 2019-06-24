Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  root to: 'user#index'

  get '/search', to: 'cards#search', as: :cards_search
  get '/cards', to: 'cards#index', as: :cards_index
  get '/remove_from_deck', to: 'cards#remove_from_deck', as: :card_remove
  get '/add_to_deck', to: 'cards#add_to_deck', as: :card_add

  namespace :api do
  	namespace :v1 do
      get 'users/deck_statistics', to: 'users#deck_statistics'
  		resources :users, only: [:index, :show]
  	end
  end
end
