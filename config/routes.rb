Rails.application.routes.draw do

  # restaurants area
  resources :categories, only: [:create, :new, :edit, :update, :destroy]
  resources :restaurants # TODO: remove it

  constraints subdomain: /.+/  do
    get '/' => 'restaurants#show'

    scope '/admin' do
      get '/' => 'admin#index', as: :admin
      match 'allergens' => "admin#allergens", as: :admin_allergens, via: [:get, :post]
      match 'dishes' => "admin#dishes", as: :admin_dishes, via: [:get, :post]
      match 'menus' => "admin#menus", as: :admin_menus, via: [:get, :post]
    end



    patch 'activate_module' => "restaurants#activate_module"

    match 'opening_hours/edit' => "opening_hours#edits", as: :opening_hours_edit, via: [:get, :post]
    resources :opening_hours, only: [:create, :destroy]

    resources :posts

    match 'links/edit' => "links#edits", as: :links_edit, via: [:get, :post]
    resources :links

    match 'sections/edit' => "sections#edits", as: :sections_edit, via: [:get, :post]
    resources :sections

    resources :menus

    resources :dishes

    get 'allergens/edit' => "allergens#edits", as: :allergens_edit
    resources :allergens, only: [:index]

    match 'categories/edit' => "categories#edits", as: :categories_edit, via: [:get, :post]
    resources :categories
  end

  # payements area
  post "/hook" => "payements#hook", as: :payement_hook
  resources :payements

  # session
  resources :users
  resources :user_sessions, only: [:create, :destroy]
  get 'signout', to: 'user_sessions#destroy'
  get 'signin', to: 'user_sessions#new'
  get "signup" => "users#new"
  get "confirm_email/:token" => "users#confirm_email", as: 'confirm_email'
  resources :password_resets, :only => [ :new, :create, :edit, :update ]

  # pages area
  match 'contact' => 'pages#contact', via: [:get, :post]
  get 'cost' => 'pages#cost'
  get "home" => "pages#home"
  get '/', to:  'restaurants#show', constraints: { subdomain: 'le-petit-lagon-bleu'}, as: :example

  resources :newsletters, only: [:create, :destroy]

  root 'pages#home'
end
