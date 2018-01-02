# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'routing to account' do
  describe 'GET /account' do
    it 'routes to account#edit' do
      expect(get: '/account').to route_to(controller: 'account', action: 'edit')
    end
  end

  describe 'PATCH /account' do
    it 'routes to account#update' do
      expect(patch: '/account').to route_to(controller: 'account', action: 'update')
    end
  end
end
