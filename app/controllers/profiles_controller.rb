# frozen_string_literal: true
class ProfilesController < ApplicationController
  before_action :authenticate_user!, except: [:show]

  def user_parameter
    params[:username] == 'me' ? current_user : User.find_by_username(params[:username])
  end

  def show
    @profile_user = user_parameter

    unless @profile_user
      # user does not exist, 404 code it up.
      response.status = 404
    end

    render 'profiles/show'
  end

  def edit
    @profile_user = user_parameter

    if @profile_user && current_user.power_over?(@profile_user)
      render 'profiles/edit'
    else
      redirect_to profile_path(params[:username])
    end
  end

  def update
    @profile_user = user_parameter

    redirect_to profile_path(params[:username]) unless current_user.power_over?(@profile_user)

    if @profile_user.profile.update_attributes(update_params)
      flash[:success] = 'Profile successfully updated.'
      redirect_to profile_path(@profile_user)
    else
      render 'edit'
    end
  end

  private

  def update_params
    params.require(:profile).permit(
        :avatar,  :avatar_cache, :remove_avatar,
        :country, :gender,       :about
    )
  end
end
