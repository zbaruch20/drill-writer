Rails.application.routes.draw do
  root "pages#index" # Root path

  namespace :api do
    namespace :v1 do
      # /api/v1 prefix for API endpoints
      resources :users, param: :username
      resources :drills
      resources :moves, only: %i(create update destroy)
    end
  end
end
