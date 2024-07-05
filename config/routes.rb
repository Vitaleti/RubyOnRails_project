Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Маршрут страницы профиля
  get "profile", to: 'users#show', as: "profile"

  # Временный маршрут для постов
  get "/posts", to: "posts#index"

  # Корень приложения для аутентифицированных пользователей
  root "users#show"
end
