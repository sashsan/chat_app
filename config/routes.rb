# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users

  resources :groups do
    resources :messages
  end

  resources :users, only: [:index]

  root 'home#index'
end
