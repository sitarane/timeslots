Rails.application.routes.draw do
  resources :bookings
  get '/:locale', to: 'pages#home'
  root 'pages#home'
  scope "(:locale)", locale: /en|de/ do
    resource :users, except: :index
    resources :calendars do
      resources :slots
    end
    resource :sessions, only: [:new, :create, :destroy]
    resource :password, only: [:edit]
    resource :password_reset, only: [:new, :edit, :update, :create]

    get 'signup', to: 'users#new'
    get 'login', to: 'sessions#new'
    get 'logout', to: 'sessions#destroy'
  end
end
