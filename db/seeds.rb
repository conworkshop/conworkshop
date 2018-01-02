# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

def seed_if_needed(klass, check, *seeds)
  raise 'argument `klass` must inherit from ActiveRecord::Base' unless klass < ActiveRecord::Base

  seeds.each do |seed|
    name = klass.model_name.to_s
    name += %( with #{check} "#{seed[check]}") if name.present?

    ActiveRecord::Base.transaction do
      begin
        if klass.find_by("#{check}": seed[check])
          Rails.logger.info("skipped #{name} because it already exists")
        else
          klass.create!(seed)
          Rails.logger.info("created #{name}")
        end
      rescue => e
        ## ignore ##
        Rails.logger.warn("skipped #{name} because of #{e}")
      end
    end
  end
end

seed_if_needed(
  Clan,
  :name,
  { name: 'Conlanger', symbol: '✱', colour: '#009999', description: 'CWS Conlanger', permission: 'I', concrete_members: false },
  { name: 'High Council of CWS', symbol: '✱', colour: '#338833', description: 'Staff of CWS', slug: 'staff', permission: 'I' },
  { name: 'Baredan Union', symbol: '⧰', colour: '#FF7700', description: 'For the best countries only', permission: 'R' },
  name: 'Avxyntklan', symbol: '木', colour: '#E64843', description: 'Hojdzan! Come and speak Xynder with us!', permission: 'O'
)

seed_if_needed(
  LangType,
  :code,
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
  code: 'OTH', name: 'Other'
)
