Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  get "recipes/new", to: "recipes#add", as: :new_recipe
  get "admin_login", to: "home#index", as: :admin_login
  resources :recipes, except: [ :new ]
  resources :ingredients

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  root "home#landing"
   # root "home#index"
   namespace :api do
    namespace :v1 do
      resources :recipes
    end
  end
end
