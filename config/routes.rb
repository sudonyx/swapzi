Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  # Defines the root path route ("/")
  # root "articles#index"
  resources :items, only: %i[index show new create destroy] do
     post 'favourite', to: 'favourites#create'
     delete 'favourite', to: 'favourites#destroy'
      resources :swaps, only: %i[new]
  end
  resources :swaps, only: %i[show create update destroy]
  resources :favourites, only: %i[index create destroy]
  get "/swaps", to: "swaps#pending"
end
