FactoryGirl.define do
  factory :user do
    email { 'cool@email.com' }
    password '0123456789'
    sequence(:username) { |n| "user#{n}" }
    group 'R'

    factory :confirmed_user do
      confirmed_at Date.today
    end
  end
end
