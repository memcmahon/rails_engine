Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      namespace :merchants do
        get '/find', to: "search#show"
        get '/find_all', to: "search#index"
        get '/random', to: "random#show"
        get '/:id/items', to: "merchant_items#show"
        get '/:id/invoices', to: "merchant_invoices#show"
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
        get "/:id/invoice_items", to: "item_invoice_items#index"
        get "/:id/merchant", to: "item_merchant#show"
        get "/:id/best_day", to: "item_best_day#show"
      end
      get '/items', to: "items#index"
      get '/items/:id', to: "items#show"
    end
  end
end
