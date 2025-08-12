Rails.application.routes.draw do
  get "contents/index"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  get "contents", to: "contents#index"
  get "search", to: "search#search"

  resources :users do
    resources :favorite_apps, only: [ :create, :index ]
    get "favorite_channel_programs", to: "favorite_channel_programs"
  end

  resources :movies, only: [ :show ]
  resources :tv_shows, only: [ :show ]
  resources :seasons, only: [ :show ]
  resources :episodes, only: [ :show ]
  resources :channels, only: [ :show ]
  resources :channel_programs, only: [ :show ]

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
end
