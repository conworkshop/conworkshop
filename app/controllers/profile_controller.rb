class ProfileController < ApplicationController
  before_action :authenticate_user!, except: [:show]

  def show
    @profile_user = User.find_by_username(params[:id])
    render 'profile/show'
  end

  def edit
    render 'profile/edit'
  end
end
