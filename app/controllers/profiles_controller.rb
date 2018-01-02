# frozen_string_literal: true

class ProfilesController < ApplicationController
  def show
    @profile_user = find_profile_for_params

    # user does not exist, 404 code it up.
    response.status = 404 unless @profile_user
  end

  def edit
    @profile_user = find_profile_for_params

    if @profile_user && current_user.power_over?(@profile_user)
      render 'profiles/edit'
    else
      redirect_to profile_path(params[:username])
    end
  end

  def update
    @profile_user = find_profile_for_params

    redirect_to profile_path(params[:username]) unless current_user.power_over?(@profile_user)

    if @profile_user.profile.update_attributes(update_params)
      flash[:success] = 'Profile successfully updated.'
      redirect_to profile_path(@profile_user)
    else
      render 'edit'
    end
  end

  private

  def find_profile_for_params
    User.joins(:profile).includes(:profile).find_by(username: params[:username])
  end

  def update_params
    params.require(:profile).permit(
      :avatar,  :avatar_cache, :remove_avatar,
      :country, :gender,       :about
    )
  end
end
