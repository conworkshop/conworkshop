# frozen_string_literal: true
require 'rails_helper'

RSpec.describe 'root path', type: :request do
  context 'given an unregistered user' do
    it 'renders the about page' do
      get '/'

      expect(response).to have_http_status(:success)
      expect(response.body).to include('Welcome')
    end
  end

  context 'given a registered member' do
    it 'renders the feed' do
      sign_in create(:confirmed_user, :with_user_track)

      get '/'

      expect(response).to have_http_status(:success)
      expect(response.body).to match(/feed/i)
    end
  end
end
