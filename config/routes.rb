Rails.application.routes.draw do
  get 'confirmations/create'
  get 'confirmations/edit'
  get 'confirmations/new'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "home#index"

  # Signup routes ("/signup")
  post "signup", to: "users#create"
  get  "signup", to: "users#new"

  # Session routes ("/login")
  post "login", to: "sessions#create"
  get  "login", to: "sessions#new"

  # Logout route ("/logout")
  delete "logout", to: "sessions#destroy"

  # Account routes ("/account")
  put    "account", to: "users#update"
  get    "account", to: "users#edit"
  delete "account", to: "users#destroy"

  # Password routes ("/passwords")
  resources :passwords, only: [:create, :edit, :new, :update], param: :password_reset_token

  # Confirmation routes
  resources :confirmations, only: [:create, :edit, :new], param: :confirmation_token

  # Active seessions
  resources :active_sessions, only: [:destroy] do
    collection do
      delete "destroy_all"
    end
  end

  # Games routes ("/games")
  resources :games

  # Play routes
  get  "play/:id",               to: "play#index", as: "play_game"
  post "join/:game_id/:user_id", to: "play#join",  as: "join_game"

  # Settings
  get 'settings/index', as: "settings"

end
