class AdminController < ApplicationController
  before_action :authenticate_user!
  before_action :auth_staff

  def langtypes_edit
    render 'langtypes_edit'
  end

  def langtypes_update
  end
end
