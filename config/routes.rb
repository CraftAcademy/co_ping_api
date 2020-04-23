# frozen_string_literal: true

Rails.application.routes.draw do
  get 'profiles/show'
  mount_devise_token_auth_for 'User', at: '/auth', skip: [:omniauth_callbacks]
  resources :pings, only: %i[create index update show]
  resources :pongs, only: %i[create update destroy show]
  resources :communities, only: [:index]
  resources :profiles, only: %i[show update]
  resources :swish, only: %i[create]
  namespace :admin do
    resources :communities, only: %i[index update]
  end
end
