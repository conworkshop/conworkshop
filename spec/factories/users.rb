FactoryGirl.define do
  factory :user do
    email 'user@example.com'
    password 'spoopy'
    sequence(:username) { |n| "user#{n}" }
    group 'R'
  end
end
