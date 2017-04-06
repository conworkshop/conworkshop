# frozen_string_literal: true
class UserController < ApplicationController
  def update_tz
    params.require(:tz)

    ret = { success: false }

    if user_signed_in?
      if current_user.timezone == params[:tz]
        ret[:success] = 'no update'
      elsif current_user.update_attributes(timezone: params[:tz])
        ret[:success] = "updated to #{params[:tz]}"
      else
        ret[:err] = 'internal error'
      end
    else
      ret[:err] = 'user is not signed in'
    end

    render json: ret
  end
end
