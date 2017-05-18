require 'rails_helper'

RSpec.describe PreferencesController, type: :controller do
  describe 'GET #edit' do
    subject { get :edit }

    it { is_expected.to have_http_status(:success) }
  end
end
