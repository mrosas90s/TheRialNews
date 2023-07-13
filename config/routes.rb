Rails.application.routes.draw do
  resources :comments
  devise_for :users
  resources :news do
    resources :comments, only: [:create, :destroy]
  end
  
  


  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "news#index"
end
