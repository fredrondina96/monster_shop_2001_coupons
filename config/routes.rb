Rails.application.routes.draw do
  root "welcome#index"

  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  namespace :admin do
    get "/", to: "dashboard#index"
    resources :users, only: [:index, :show]
      # get "/users", to: "users#index"
      # get "/users/:id", to: "users#show"

    get "/merchants", to: "merchants#index"
    get "/merchants/:merchant_id", to: "merchants#show"
    patch "/merchants/:merchant_id", to: "merchants#update"
    patch "/order/:id", to: "order#ship", as: :order_ship
    namespace :merchant do
      get ":id/items", to: "items#index", as: :items
      get ":id/items/:item_id", to: "items#show", as: :item_show
      patch ":id/items/:item_id", to: "items#update", as: :item_update
      delete "/items/:id", to: "items#destroy", as: :item_destroy
      get ":id/orders/:order_id", to: "orders#show", as: :order_show
    end
  end

  namespace :merchant do
    get "/", to: "dashboard#index"
    get "/coupons/new", to: "coupons#new", as: :coupon_new
    resources :coupons, except: [:new]
      # post "/coupons", to: "coupons#create"
      # get "/coupons", to: "coupons#index"
      # get "/coupons/:coupon_id/edit", to: "coupons#edit"
      # patch "/coupons/:coupon_id", to: "coupons#update"
      # delete "/coupons/:coupon_id", to: "coupons#destroy"

    get "/items", to: "items#index"
    get "/items/new", to: "items#new"
    post "/items", to: "items#create"
    get "/items/:id", to: "items#show", as: :item_show
    get "/items/:id/edit", to: "items#edit", as: :item_edit
    patch "/items/:id", to: "items#update", as: :item_update
    delete "/items/:id", to: "items#destroy", as: :item_destroy
    get "/orders/:id", to: "orders#show", as: :order_show
    patch "/itemorders/:id", to: "item_orders#update", as: :item_order_update
  end

  resources :merchants
  # get "/merchants", to: "merchants#index"
  # get "/merchants/new", to: "merchants#new"
  # get "/merchants/:id", to: "merchants#show"
  # post "/merchants", to: "merchants#create"
  # get "/merchants/:id/edit", to: "merchants#edit"
  # patch "/merchants/:id", to: "merchants#update"
  # delete "/merchants/:id", to: "merchants#destroy"

  get "/merchants/:merchant_id/items", to: "items#index"
  get "/merchants/:merchant_id/items/new", to: "items#new"
  post "/merchants/:merchant_id/items", to: "items#create"

  get "/items", to: "items#index"
  get "/items/:id", to: "items#show", as: :item_show


  get "/items/:item_id/reviews/new", to: "reviews#new"
  post "/items/:item_id/reviews", to: "reviews#create"

  get "/reviews/:id/edit", to: "reviews#edit"
  patch "/reviews/:id", to: "reviews#update"
  delete "/reviews/:id", to: "reviews#destroy"

  post "/cart/:item_id", to: "cart#add_item"
  get "/cart", to: "cart#show"
  patch "/cart/:item_id", to: "cart#update", as: :update_cart
  delete "/cart", to: "cart#empty"
  delete "/cart/:item_id", to: "cart#remove_item"

  resources :orders, only: [:new, :create]
  # get "/orders/new", to: "orders#new"
  # post "/orders", to: "orders#create"
  get "/orders/:id", to: "orders#show", as: :order_show
  patch "/orders/:id", to: "orders#cancel", as: :order_cancel


  get "/register", to: "users#new"

  post "/profile", to: "users#create"
  get "/profile", to: "users#show"
  get "/profile/edit", to: 'users#edit'
  patch "/profile/update", to: 'users#update'
  get "/profile/change_password", to: "users#change_password"
  patch "/profile/update_password", to: "users#update_password"
  get "profile/orders", to: "user/orders#index", as: :user_orders
  get "profile/orders/:order_id", to: "user/orders#show", as: :user_order_show
end
