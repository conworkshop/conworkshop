FactoryGirl.define do
  factory :user_track do
    association :user, strategy: :build

    factory :online_user_track do
      tracked_at { Time.now }
    end

    factory :away_user_track do
      tracked_at { 5.minutes.ago }
    end

    factory :offline_user_track do
      tracked_at { 30.minutes.ago }
    end
  end
end
