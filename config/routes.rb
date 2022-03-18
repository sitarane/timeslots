Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  get '/:locale', to: 'pages#home'
  root 'pages#home'
  scope "/:locale" do
    resource :users, except: :index
    resource :sessions, only: [:new, :create, :destroy]
    resource :password, only: [:edit]
    resource :password_reset, only: [:new, :edit, :update, :create]

    get 'signup', to: 'users#new'
    get 'login', to: 'sessions#new'
    get 'logout', to: 'sessions#destroy'
  end
end
