FactoryGirl.define do
  factory :user do
    email { 'cool@email.com' }
    password '0123456789'
    sequence(:username) { |n| "user#{n}" }
    group 'R'
  end
end
