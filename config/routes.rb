Rails.application.routes.draw do
  # Profile
  get 'user/:id', to: 'profile#show', constraints: { id: %r{[^/]+} }, as: :profile_show
  get 'profile/edit', to: 'profile#edit', as: :profile_edit

  # Static pages
  get 'about', to: 'static#about', as: :page_static_about

  # Root
  root 'static#about'

  devise_for :users, controllers: { registrations: 'users/registrations', sessions: 'users/sessions' }, path: '', path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'signup' }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
