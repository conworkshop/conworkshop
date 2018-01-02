# frozen_string_literal: true

class AccountController < ApplicationController
  def edit
  end

  def update
    if current_user.update_attributes(update_params)
      flash[:success] = 'Account settings successfully updated.'
      redirect_to profile_path(current_user)
    else
      render 'edit'
    end
  end

  private

  def update_params
    params[:user][:pseudonym] = nil if params[:user][:pseudonym].blank?
    params.require(:user).permit(:email, :pseudonym)
  end
end
