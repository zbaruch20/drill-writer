Rails.application.routes.draw do
  root "pages#index" # Root path

  defaults format: :json do
    namespace :api do
      namespace :v1 do
        # /api/v1 prefix for API endpoints
        resources :users, param: :username
        resources :drills
        resources :moves, only: %i(create update destroy)
      end
    end
  end

  get "*path", to: "pages#index", via: :all # Redirect all other paths to index
end
