Rails.application.routes.draw do
  devise_for :users, path: "accounts"
  root to: "pages#home"

  # Defines the root path route ("/")
  # root "articles#index"

  resources :items, only: %i[index show new create destroy] do
    resources :favourites, only: %i[create]
    resources :swaps, only: %i[new]
  end

  resources :users, only: [] do
    get 'profile', on: :collection
  end

  get "/swaps", to: "swaps#pending"
  get "/swaps/completed", to: "swaps#completed"

  resources :swaps, only: %i[show create update destroy]

  resources :favourites, only: %i[index destroy]

  resources :conversations, only: %i[index show create] do
    resources :messages, only: :create
  end

  get "/dashboard", to: "users#dashboard"
  get "/about_points",to: "pages#about_points"

  # patch "/update_swapzi_score", to: "users#update_swapzi_score"
end
