Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  namespace :api do
    namespace :v1 do
      resources :items, only: [ :index, :show, :create ]
      resource :cart, only: [ :show ] do
        post "add_item"
        post "remove_item"
      end
      resources :promotions, only: [ :index, :create ]
    end
  end
end
