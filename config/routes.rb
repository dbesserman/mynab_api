Rails.application.routes.draw do
  namespace :api do
    resources :groups, only: :index
    resources :transactions, only: :index
  end
end
