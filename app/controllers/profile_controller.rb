class ProfileController < ApplicationController
  def show
    @profile_user = User.find_by_username(params[:id])
    render 'profile/show'
  end
end
