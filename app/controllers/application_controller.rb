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

  # Use AccessControl to see if the user is authorized to access this page as per the config.
  def authorize_route
    route_str = controller_path + '#' + action_name
    route_ctl = CWS::ACCESS_CONTROL.get(route_str)

    # Authenticate user if this route isn't for anyone.
    authenticate_user! unless route_ctl&.anyone?

    unless !route_ctl || route_ctl&.allowed?(current_user)
      # get rekt
      reason = if route_ctl&.maintenance?
                 :maintenance
               else
                 current_user&.banned? ? :banned : :unauthorized
               end

      render '403', status: 403, locals: { reason: reason }
    end
  end

  # Tracks an user's current route, and stores it on the database with UserTrack.
  # Used for: online/away/offline detection; "online now" on the feed
  def track_user
    return unless user_signed_in? # ignore guests

    UserTrack.where(user: current_user)
             .update_all(route: controller_path + '#' + action_name, tracked_at: Time.current)
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
    current_user&.preferences&.fetch(:locale, nil) || locale_from_accept_language || I18n.default_locale
  end

  def locale_from_accept_language
    http_accept_language.compatible_language_from(I18n.available_locales)
  end
end
