Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

  # Defines the root path route ("/")
  # root "articles#index"

  resources :items, only: %i[index show new create destroy] do
    resources :favourites, only: %i[create destroy]
    resources :swaps, only: %i[new]
  end

  get "/swaps", to: "swaps#pending"
  get "/swaps/completed", to: "swaps#completed"

  resources :swaps, only: %i[show create update destroy]

  resources :favourites, only: %i[index]
end
