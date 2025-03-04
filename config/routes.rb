# frozen_string_literal: true

require "sidekiq/web"

Rails.application.routes.draw do
  get  "sign_in", to: "sessions#new"
  post "sign_in", to: "sessions#create"
  get  "sign_up", to: "registrations#new"
  post "sign_up", to: "registrations#create"
  resources :sessions, only: [:index, :show, :destroy]
  resource  :password, only: [:edit, :update]
  namespace :identity do
    resource :email,              only: [:edit, :update]
    resource :email_verification, only: [:show, :create]
    resource :password_reset,     only: [:new, :edit, :create, :update]
  end
  resource :account, only: [:show]
  resources :jobs

  namespace :job do
    resources :saves, only: [:index, :update]
    resources :rejects, only: [:index, :update]
  end

  mount Sidekiq::Web => "/sidekiq" # mount Sidekiq::Web in your Rails app


  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
