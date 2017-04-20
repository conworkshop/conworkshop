# frozen_string_literal: true
Rails.application.routes.draw do
  # Root
  root 'static#feed'

  # Devise
  devise_for :users,
    controllers: { registrations: 'users/registrations', sessions: 'users/sessions' },
    path: '',
    path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'signup' }

  # Static pages
  get 'about', to: 'static#about', as: :page_static_about

  # Profile
  resources :profiles, only: [:show, :edit, :update], param: :username

  # Account
  resource :account, only: [:edit, :update], controller: 'account'

  # Language
  resources :languages, only: [:show, :update, :new, :create], id: /[a-zA-Z0-9]{3}/

  # Admin
  namespace :admin do
    # Admin::Langtypes
    resources :langtypes, only: [:index, :edit, :update]
  end
end
