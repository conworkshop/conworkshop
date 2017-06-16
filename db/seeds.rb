# frozen_string_literal: true
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

RouteAccessControl.delete_all
RouteAccessControl.create!([
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
  { route: 'clans#new',                         level:  0 },
  { route: 'clans#create',                      level:  0 },
  { route: 'clans#show',                        level:  0 },
  { route: 'clans#index',                       level:  0 },
  { route: 'clans#join',                        level:  0 },
  { route: 'clans#primary',                     level:  0 },
  { route: 'devise/confirmations#new',          level: -1 },
  { route: 'devise/confirmations#show',         level: -1 }
])

Clan.delete_all
Clan.create!([
  { name: 'Conlanger', symbol: '✱', colour: '#009999', description: 'CWS Conlanger', permission: 'I', concrete_members: false },
  { name: 'High Council of CWS', symbol: '✱', colour: '#338833', description: 'Staff of CWS', slug: 'staff', permission: 'I' },
  { name: 'Baredan Union', symbol: '⧰', colour: '#FF7700', description: 'For the best countries only', permission: 'R' },
  { name: 'Avxyntklan', symbol: '木', colour: '#E64843', description: 'Hojdzan! Come and speak Xynder with us!', permission: 'O'}
])
ClanMembership.delete_all

LangType.delete_all
LangType.create!([
  { code: 'NSP', name: 'Not specified'                          },
  { code: 'APR', name: 'A priori'                               },
  { code: 'APS', name: 'A posteriori'                           },
  { code: 'ART', name: 'Artistic Language (Artlang)'            },
  { code: 'ENG', name: 'Engineered Language (Englang)'          },
  { code: 'IAL', name: 'International Auxiliary Language (IAL)' },
  { code: 'LOG', name: 'Logical Language (Loglang)'             },
  { code: 'SGN', name: 'Signed conlang'                         },
  { code: 'PRO', name: 'Proto-Conlang'                          },
  { code: 'PID', name: 'Pidgin'                                 },
  { code: 'CRE', name: 'Creole'                                 },
  { code: 'JOK', name: 'Joke language'                          },
  { code: 'MIX', name: 'Mixed'                                  },
  { code: 'OTH', name: 'Other'                                  },
])
