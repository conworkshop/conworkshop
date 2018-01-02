# frozen_string_literal: true

require_relative '20170415230307_create_route_access_controls'

class RemoveRouteAccessControl < ActiveRecord::Migration[5.0]
  def change
    revert CreateRouteAccessControls
  end
end
