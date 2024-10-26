Rails.application.routes.draw do
  devise_for :users

  get "up" => "rails/health#show", as: :rails_health_check

  get "users/", to: "users#other_users", as: "users"
  get "users/:nickname", to: "users#other_user", as: "other_user"
  get ":nickname", to: "users#show", as: "profile"
  get ":nickname/edit", to: "users#edit", as: "edit_profile"
  patch ":nickname", to: "users#update", as: "update_profile"

  get ":nickname/posts/new", to: "posts#new", as: "post_new"
  get ":nickname/posts/:id/edit", to: "posts#edit", as: "post_edit"
  post ":nickname/posts", to: "posts#create", as: :create_post
  patch ":nickname/posts/:id", to: "posts#update", as: "update_post"
  put ":nickname/posts/:id", to: "posts#update"
  delete ":nickname/posts/:id", to: "posts#destroy", as: "delete_post"
  get ":nickname/posts", to: "posts#index", as: "posts"

  resources :users, only: [:show] do
    member do
      get :followers, :following
    end
  end

  resources :subscriptions, only: [:create, :destroy]

  resources :posts, only: [] do
    member do
      post 'like', to: 'likes#create'
      delete 'like', to: 'likes#destroy'
      get 'show', to: 'posts#show', as: :show
    end
    resources :comments, only: [:create, :destroy]
  end

  root "home#index"
end