# frozen_string_literal: true
class LanguagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show]

  def show
  end

  def new
    @language = Language.new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
