require 'rails_helper'

RSpec.describe UserTrack, type: :model do
  describe '#status' do
    context 'when #tracked_at is less than 5 minutes ago' do
      subject { build(:online_user_track).status }
      it { is_expected.to eq :online }
    end

    context 'when #tracked_at is between 5 minutes and 30 minutes ago' do
      subject { build(:away_user_track).status }
      it { is_expected.to eq :away }
    end

    context 'when #tracked_at is more than 30 minutes ago' do
      subject { build(:offline_user_track).status }
      it { is_expected.to eq :offline }
    end
  end
end
