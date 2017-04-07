# frozen_string_literal: true
class StaticController < ApplicationController
  def about; end

  def feed
    render 'about' unless user_signed_in?
  end
end
