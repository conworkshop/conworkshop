# frozen_string_literal: true
class PreferencesController < ApplicationController
  before_action :authenticate_user!

  def edit
  end

  def update
    current_user.preferences[:locale] = update_params[:locale]

    if current_user.save
      flash[:success] = 'Preferences successfully updated.'
    end

    redirect_to preferences_path(locale: current_user.locale)
  end

  private

  def update_params
    params.require(:user).permit(:locale)
  end
end
