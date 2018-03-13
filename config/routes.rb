Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      namespace :merchants do
        resources :find, to: "search#show"
        resources :find_all, to: "search#index"
      end
      get '/merchants', to: "merchants#index"
      get '/merchants/:id', to:"merchants#show"
    end
  end
end
