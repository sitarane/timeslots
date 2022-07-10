Rails.application.routes.draw do
  devise_for :users
  resources :bookings, only: [:create, :update]
  get '/:locale', to: 'pages#home'
  root 'pages#home'
  scope "(:locale)", locale: /en|de/ do
    resource :users, only: [:new, :create, :update] # for now...
    resources :calendars do
      resources :slots, except: :index
      resources :calendar_assignations, only: :destroy
    end
    # resource :sessions, only: [:new, :create, :destroy]
    # resource :password, only: [:edit]
    # resource :password_reset, only: [:new, :edit, :update, :create]

    # get 'signup', to: 'users#new'
    # get 'login', to: 'sessions#new'
    # get 'logout', to: 'sessions#destroy'
  end
end
