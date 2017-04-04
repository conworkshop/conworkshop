# frozen_string_literal: true
Rails.application.routes.draw do
  # Profile
  get 'user/:username', to: 'profile#show', constraints: { username: %r{[^/]+} }, as: :user
  get 'user/:username/edit', to: 'profile#edit', constraints: { username: %r{[^/]+} }, as: :profile_edit
  patch 'user/:username/edit', to: 'profile#update', constraints: { username: %r{[^/]+} }, as: :profile_update

  # Timezone thing
  patch 'user/update_tz', to: 'user#update_tz', constraints: { format: 'json' }, as: :user_update_tz

  # Static pages
  get 'about', to: 'static#about', as: :page_static_about
  get 'feed', to: 'static#feed', as: :page_static_feed

  # Root
  root 'static#feed'

  devise_for :users, controllers: { registrations: 'users/registrations', sessions: 'users/sessions' }, path: '', path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'signup' }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
