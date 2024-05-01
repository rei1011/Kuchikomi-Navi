Rails.application.routes.draw do
  resources :comments
  get "up" => "rails/health#show", :as => :rails_health_check
end
