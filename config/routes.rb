Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Маршрут страницы профиля
  get "profile", to: 'users#show', as: "profile"

  # Устанавливаем root страницу на страницу профиля после входа
  authenticated :user do
    root "users#show", as: :authenticated_root
  end

  # Корень приложения для неаутентифицированных пользователей
  root "home#index"
end
