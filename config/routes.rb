Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      namespace :merchants do
        get '/find', to: "search#show"
        get '/find_all', to: "search#index"
        get '/random', to: "random#show"
        get '/:id/items', to: "merchant_items#show"
        get '/:id/invoices', to: "merchant_invoices#show"
        get '/most_revenue', to: "revenue#index"
        get '/:id/favorite_customer', to: "favorite_customer#show"
        get '/:id/revenue', to: "revenue#show"
        get '/revenue', to: "revenue_by_date#show"
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
        get '/:id/transactions', to: "invoice_transactions#index"
        get '/:id/invoice_items', to: "invoice_invoice_items#index"
        get '/:id/items', to: "invoice_items#index"
        get '/:id/customer', to: "invoice_customer#show"
        get '/:id/merchant', to: "invoice_merchant#show"
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

      namespace :invoice_items do
        get '/:id/invoice', to: "invoice_item_invoice#show"
        get '/:id/item', to: "invoice_item_item#show"
      end
    end
  end
end
