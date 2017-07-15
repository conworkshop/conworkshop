FactoryGirl.define do
  factory :user do
    email { 'cool@email.com' }
    password '0123456789'
    sequence(:username) { |n| "user#{n}" }
    group 'R'

    factory :confirmed_user do
      confirmed_at Date.today
    end

    trait :with_user_track do
      after :create do |u|
        u.user_track = create(:online_user_track, user: u)
      end
    end
  end
end
