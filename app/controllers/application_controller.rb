# frozen_string_literal: true
class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :authorize_route
  before_action :track_user
  before_action :set_locale

  def default_url_options
    { locale: I18n.locale }
  end

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

    # Tracks an user's current route, and stores it on the database with UserTrack.
    # Used for: online/away/offline detection; "online now" on the feed
    def track_user
      return unless user_signed_in? # ignore guests

      UserTrack.transaction do
        ut = UserTrack.lock.find_or_initialize_by(user: current_user)

        ut.route      = controller_path + '#' + action_name
        ut.tracked_at = Time.now

        ut.save(validate: false) # no need to validate because there's nothing to validate
      end
    end

    def set_locale
      # basically, the default locale on the URL is `nil`. this means that the
      # system will use the guessed locale.
      #  * example path: /profile/unleashy (no locale prefix, locale guessed)
      # if it isn't the default nil, then use the params[:locale].
      #  * example path: /pt/profile/unleashy -> locale is :pt
      I18n.locale = params[:locale] ? params[:locale].to_sym : guess_locale
    end

    def guess_locale
      current_user&.preferences[:locale] || locale_from_accept_language || I18n.default_locale
    end

    def locale_from_accept_language
      http_accept_language.compatible_language_from(I18n.available_locales)
    end
  end
end
