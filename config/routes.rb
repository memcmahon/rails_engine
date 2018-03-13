Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      namespace :merchants do
        resources :find, only: [:index], to: "search#show"
      end
      resources :merchants, only: [:index, :show]
    end
  end
end
