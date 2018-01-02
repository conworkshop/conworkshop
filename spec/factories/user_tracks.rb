# frozen_string_literal: true

FactoryGirl.define do
  factory :user_track do
    tracked_at 0
    association :user, strategy: :build

    factory :online_user_track do
      tracked_at { Time.current }
    end

    factory :away_user_track do
      tracked_at { 5.minutes.ago }
    end

    factory :offline_user_track do
      tracked_at { 30.minutes.ago }
    end
  end
end
