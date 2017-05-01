# frozen_string_literal: true
class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :authorize_route

  private

  # Use RouteAccessControl to see if the user is authorized to access this page.
  def authorize_route
    route_str = controller_path + '#' + action_name

    unless (access = RouteAccessControl.find_by(route: route_str))
      # Create new row, since it doesn't exist.
      # Defaults to the special maintenance level, which allows entry to
      # developers only.
      access = RouteAccessControl.create(
        route: route_str,
        level: RouteAccessControl::MAINTENANCE_LEVEL
      )
    end

    unless access.allowed?(current_user)
      # get rekt
      reason = if access.maintenance?
                 :maintenance
               else
                 current_user&.banned? ? :banned : :unauthorized
               end

      render '403', status: 403, locals: { reason: reason }
    end
  end
end
