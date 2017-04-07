# frozen_string_literal: true
class ProfileController < ApplicationController
  before_action :authenticate_user!, except: [:show]

  def user_parameter
    params[:username] == 'me' ? current_user : User.find_by_username(params[:username])
  end

  def show
    @profile_user = user_parameter
    render 'profile/show'
  end

  def edit
    @profile_user = user_parameter
    if @profile_user
      if current_user.power_over?(@profile_user)
        render 'profile/edit'
      else
        redirect_to user_path(params[:username])
      end
    else
      render 'profile/show'
    end
  end

  def update
    @profile_user = user_parameter

    if current_user.power_over?(@profile_user)

      if @profile_user.profile.update_attributes(update_params)

        flash[:success] = 'Profile successfully updated.'
        redirect_to user_path(@profile_user)

      else
        render 'edit'
      end

    else
      redirect_to user_path(params[:username])
    end
  end

  private

  def update_params
    params.require(:profile).permit(:avatar, :avatar_cache, :remove_avatar)
  end
end
