# frozen_string_literal: true
class StaticController < ApplicationController
  def about; end

  def feed
    redirect_to page_static_about_path unless user_signed_in?
  end
end
