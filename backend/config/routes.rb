# frozen_string_literal: true

Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  resources :comments
  get 'stores', to: 'stores#index'
  resources :rooms, only: %i[index create update show destroy] do
    resources :messages, only: %i[index]
  end
  get 'error_test', to: 'stores#error_test'
  get 'up' => 'rails/health#show', :as => :rails_health_check
end
