Rails.application.routes.draw do
  get 'users/show'

  get 'sanctum/csrf-cookie', to: 'sessions#csrf'

  post 'login', to: 'sessions#create'
  post 'logout', to: 'sessions#destroy'
  get 'api/user', to: 'users#show'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
