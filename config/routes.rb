Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Маршрут просмотра списка пользователей
  get "users/", to: "users#other_users", as: "users"

  # Маршрут просмотра страниц пользователей
  get "users/:nickname", to: "users#other_user", as: "other_user"

  # Маршрут страницы профиля
  get ":nickname", to: "users#show", as: "profile"

  # Создание нового поста
  get ":nickname/posts/new", to: "posts#new", as: "post_new"

  # Редактирование поста
  get ":nickname/posts/:id/edit", to: "posts#edit", as: "post_edit"
  
  post ":nickname/posts", to: "posts#create", as: :create_post

  # Обновление поста
  patch ":nickname/posts/:id", to: "posts#update", as: "update_post"
  put ":nickname/posts/:id", to: "posts#update"

  delete ":nickname/posts/:id", to: "posts#destroy", as: "delete_post"

  # Временный маршрут для постов
  get ":nickname/posts", to: "posts#index", as: "posts"


  resources :users, only: [:show] do
    member do
      get :followers, :following
    end
  end

  resources :subscriptions, only: [:create, :destroy]

  resources :posts do
    member do
      post 'like', to: 'likes#create'
      delete 'like', to: 'likes#destroy'
    end
  end

  root "home#index"
end
