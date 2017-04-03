Rails.application.routes.draw do
  # Profile
  get 'user/:username', to: 'profile#show', constraints: { username: %r{[^/]+} }, as: :user
  get 'user/:username/edit', to: 'profile#edit', constraints: { username: %r{[^/]+} }, as: :profile_edit
  patch 'user/:username/edit', to: 'profile#update', constraints: { username: %r{[^/]+} }, as: :profile_update

  # Static pages
  get 'about', to: 'static#about', as: :page_static_about

  # Root
  root 'static#about'

  devise_for :users, controllers: { registrations: 'users/registrations', sessions: 'users/sessions' }, path: '', path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'signup' }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
