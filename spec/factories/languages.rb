# frozen_string_literal: true

FactoryGirl.define do
  factory :language do
    code 'ABC'
    name 'Abclang'
    nativename 'Abclang'

    association :user, strategy: :build
  end
end
