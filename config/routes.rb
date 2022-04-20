Rails.application.routes.draw do
  get 'confirmations/create'
  get 'confirmations/edit'
  get 'confirmations/new'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "home#index"

  # Signup routes ("/signup")
  post "signup", to: "users#create"
  get "signup", to: "users#new"

  # Confirmation routes
  resources :confirmations, only: [:create, :edit, :new], param: :confirmation_token
end
