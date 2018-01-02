# frozen_string_literal: true

FactoryGirl.define do
  factory :clan_membership do
    user nil
    clan nil
    role 'MyString'
  end
end
