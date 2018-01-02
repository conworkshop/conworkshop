# frozen_string_literal: true

FactoryBot.define do
  factory :clan_membership do
    user nil
    clan nil
    role 'MyString'
  end
end
