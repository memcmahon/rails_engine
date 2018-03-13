Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      namespace :merchants do
        get '/find', to: "search#show"
        get '/find_all', to: "search#index"
        get '/random', to: "random#show"
      end
      get '/merchants', to: "merchants#index"
      get '/merchants/:id', to:"merchants#show"
    end
  end
end
