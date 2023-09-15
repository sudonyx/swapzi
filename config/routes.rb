Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

  resources :items, only: %i[index show new create destroy] do
    post 'favourite', to: 'favourites#create'
    delete 'favourite', to: 'favourites#destroy'
  end
end
