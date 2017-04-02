class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_locale

  def set_locale
    # TODO: = current_user.try(:locale) || I18n.default_locale
    I18n.locale = I18n.default_locale
  end
end
