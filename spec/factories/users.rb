FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    password '0123456789'
    sequence(:username) { |n| "user#{n}" }
    group 'R'
  end
end
