# frozen_string_literal: true

class PreferencesController < ApplicationController
  def edit
  end

  def update
    current_user.preferences[:locale] = update_params[:preferences][:locale]

    flash[:success] = 'Preferences successfully updated.' if current_user.save

    redirect_to preferences_path(locale: current_user.preferences[:locale])
  end

  private

  def update_params
    params.require(:user).permit(preferences: [:locale])
  end
end
