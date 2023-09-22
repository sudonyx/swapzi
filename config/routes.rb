Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

  # Defines the root path route ("/")
  # root "articles#index"
  get '/user/dashboard' => "users#dashboard", :as => :user_root

  resources :items, only: %i[index show new create destroy] do
    resources :favourites, only: %i[create destroy]
    resources :swaps, only: %i[new]
  end

  resources :swaps, only: %i[show create update destroy]
  get "/swaps", to: "swaps#pending"

  resources :users, only: %i[dashboard]
end
