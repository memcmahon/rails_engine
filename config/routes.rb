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

      namespace :transactions do
        get '/find', to: "search#show"
        get '/find_all', to: "search#index"
        get '/random', to: "random#show"
      end
      get '/transactions', to: "transactions#index"
      get '/transactions/:id', to: "transactions#show"

      namespace :customers do
        get '/find', to: "search#show"
        get '/find_all', to: "search#index"
        get '/random', to: "random#show"
      end
      get '/customers', to: "customers#index"
      get '/customers/:id', to: "customers#show"

      namespace :invoices do
        get "/find" => "search#show"
        get "/find_all" => "search#index"
        get "/random" => "random#show"
      end
      get '/invoices', to: "invoices#index"
      get '/invoices/:id', to: "invoices#show"

      namespace :items do
        get "/find" => "search#show"
        get "/find_all" => "search#index"
        get "/random" => "random#show"
      end
      get '/items', to: "items#index"
      get '/items/:id', to: "items#show"
    end
  end
end
