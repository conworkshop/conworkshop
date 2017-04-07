# frozen_string_literal: true
class ProfileController < ApplicationController
  before_action :authenticate_user!, except: [:show]

  def profile_user
    params[:username] == 'me' ? current_user : User.find_by_username(params[:username])
  end

  def show
    @profile_user = profile_user
    render 'profile/show'
  end

  def edit
    @profile_user = profile_user

    render 'profile/show' unless @profile_user

    if current_user.power_over(@profile_user)
      render 'profile/edit'
    else
      redirect_to user_path(params[:username])
    end
  end

  def update
    @profile_user = profile_user

    redirect_to user_path(params[:username]) unless current_user.power_over(@profile_user)

    if @profile_user.profile.update_attributes(update_params)
      flash[:success] = 'Profile successfully updated.'
      redirect_to user_path(@profile_user)
    else
      render 'edit'
    end
  end

  private

  def update_params
    params.require(:profile).permit(:avatar, :avatar_cache, :remove_avatar)
  end
end
