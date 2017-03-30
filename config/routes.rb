Rails.application.routes.draw do

  
  resources :payements
  get 'cost' => 'pages#cost'

  resources :categories, only: [:create, :new, :edit, :update, :destroy]
  resources :restaurants # TODO: remove it


  constraints subdomain: /.+/  do
    get 'contact' => "restaurants#contact"
    get 'allergens' => "restaurants#allergens"
    patch 'activate_module' => "restaurants#activate_module"

    resources :opening_hours, only: [:index, :create, :update, :destroy]
    resources :posts
    
    match 'links/edit' => "links#edits", as: :links_edit, via: [:get, :post]
    resources :links
    
    match 'sections/edit' => "sections#edits", as: :sections_edit, via: [:get, :post]
    resources :sections

    match 'menus/edit' => "menus#edits", as: :menus_edit, via: [:get, :post]
    resources :menus

    match 'dishes/edit' => "dishes#edits", as: :dishes_edit, via: [:get, :post]
    resources :dishes

    match 'categories/edit' => "categories#edits", as: :categories_edit, via: [:get, :post]
    resources :categories
  end


  resources :users
  resources :user_sessions, only: [:create, :destroy]


  get 'signout', to: 'user_sessions#destroy'
  get 'signin', to: 'user_sessions#new'
  get "signup" => "users#new"

  get "home" => "pages#home"
  get '/' => 'restaurants#show', constraints: { subdomain: /.+/ }
  get '/', to:  'restaurants#show', constraints: { subdomain: 'le-petit-lagon-bleu'}, as: :example

  root 'pages#home'
end
