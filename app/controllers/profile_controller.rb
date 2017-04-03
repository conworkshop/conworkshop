# frozen_string_literal: true
class ProfileController < ApplicationController
  before_action :authenticate_user!, except: [:show]

  def show
    @profile_user = User.find_by_username(params[:username])
    render 'profile/show'
  end

  def edit
    @profile_user = User.find_by_username(params[:username])
    if current_user.power_over(@profile_user)
      render 'profile/edit'
    else
      redirect_to user_path(params[:username])
    end
  end

  def update
    @profile_user = User.find_by_username(params[:username])

    if current_user.power_over(@profile_user)

      if @profile_user.update_attributes(update_params)

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
    params[:user][:pseudonym] = nil if params[:user][:pseudonym].blank?
    params.require(:user).permit(:email, :pseudonym, :avatar, :avatar_cache, :remove_avatar)
  end
end
