Rails.application.routes.draw do

  
  get 'cost' => 'pages#cost'

  resources :categories, only: [:create, :new, :edit, :update, :destroy]

  resources :restaurants do
    get 'contact'
    post 'activate_module'

    post 'opening_hours' => 'restaurants#opening_hours'
    patch 'opening_hour' => 'restaurants#opening_hours'

    resources :menus
    resources :posts
    resources :dishes
    resources :sections
  end


  resources :users
  resources :user_sessions, only: [:create, :destroy]

  get "home" => "pages#home"

  delete 'signout', to: 'user_sessions#destroy'
  get 'signin', to: 'user_sessions#new'
  get "signup" => "users#new"

  root "pages#home"
end
