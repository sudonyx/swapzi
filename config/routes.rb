Rails.application.routes.draw do
  devise_for :users, path: "accounts"
  root to: "pages#home"

  # Defines the root path route ("/")
  # root "articles#index"

  patch "items/:id/relist", to: "items#relist", as: "relist_item"
  patch "items/:id/feature", to: "items#feature", as: "feature_item"

  resources :items do
    resources :favourites, only: %i[create]
    resources :swaps, only: %i[new]
  end

  resources :users, only: [] do
    get '/profile', to: "users#profile"
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
