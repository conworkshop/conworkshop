# frozen_string_literal: true
class StaticController < ApplicationController
  skip_before_action :authenticate_user!

  def about
  end

  def feed
    render 'about' unless user_signed_in?
  end
end
