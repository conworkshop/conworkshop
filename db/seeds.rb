# frozen_string_literal: true
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

RouteAccessControl.create([
  { route: 'static#feed',                       level: -1 },
  { route: 'static#about',                      level: -1 },
  { route: 'users/registrations#new',           level: -1 },
  { route: 'users/registrations#create',        level: -1 },
  { route: 'users/sessions#new',                level: -1 },
  { route: 'users/sessions#create',             level: -1 },
  { route: 'users/sessions#destroy',            level:  0 },
  { route: 'profiles#show',                     level: -1 },
  { route: 'profiles#edit',                     level:  0 },
  { route: 'profiles#update',                   level:  0 },
  { route: 'account#edit',                      level:  0 },
  { route: 'account#update',                    level:  0 },
  { route: 'admin/langtypes#index',             level:  1 },
  { route: 'admin/langtypes#edit',              level:  1 },
  { route: 'admin/langtypes#update',            level:  1 },
  { route: 'languages#show',                    level: -1 },
  { route: 'languages#new',                     level:  0 },
  { route: 'languages#update',                  level:  0 },
  { route: 'languages#create',                  level:  0 },
  { route: 'users/omniauth_callbacks#facebook', level: -1 },
  { route: 'users/omniauth_callbacks#failure',  level: -1 },
  { route: 'preferences#edit',                  level:  0 },
  { route: 'preferences#update',                level:  0 },
])
