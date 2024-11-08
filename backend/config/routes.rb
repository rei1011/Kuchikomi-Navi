# frozen_string_literal: true

Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  resources :comments
  get 'stores', to: 'stores#index'
  resources :rooms, only: %i[index create]
  get 'error_test', to: 'stores#error_test'
  get 'comparison_report', to: 'comparison_report#show'
  get 'up' => 'rails/health#show', :as => :rails_health_check
end
