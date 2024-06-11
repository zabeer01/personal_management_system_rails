Rails.application.routes.draw do

  
  resources :categories
  resources :items
  get 'collections', to: 'items#collections', as: 'collections'
  post 'items/:id/add_to_collection', to: 'items#add_to_collection', as: 'add_to_collection'
  delete 'items/:id/remove_from_collection', to: 'items#remove_from_collection', as: 'remove_from_collection'
  devise_for :users
  resources :landing_pages
  resources :users  # Add destroy route
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  

  resources :tickets
  get 'help', to: 'tickets#help', as: 'help_tickets'
  # Defines the root path route ("/")
  root "landing_pages#index"
end
