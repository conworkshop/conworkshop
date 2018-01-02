# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PreferencesController, type: :controller do
  before { sign_in create(:confirmed_user) }

  describe '#edit' do
    subject { get :edit }

    it { is_expected.to have_http_status(:success) }
  end
end
