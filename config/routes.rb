Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  get '/user/dashboard' => "users#dashboard", :as => :user_root

  resources :items, only: %i[index show new create destroy] do
    resources :swaps, only: %i[new]
  end
  resources :swaps, only: %i[show create]

  resources :users, only: %i[] do
    get 'dashboard'
  end
end
