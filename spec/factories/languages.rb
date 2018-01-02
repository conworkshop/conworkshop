# frozen_string_literal: true

FactoryBot.define do
  factory :language do
    code 'ABC'
    name 'Abclang'
    nativename 'Abclang'

    association :user, strategy: :build
  end
end
