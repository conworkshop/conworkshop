# frozen_string_literal: true
class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def auth_admin
    current_user.rank?(2)
  end

  def auth_staff
    current_user.rank?(1)
  end
end
