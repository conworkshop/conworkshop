# frozen_string_literal: true

class WordlinksController < ApplicationController
  def index; end

  def show; end

  def new; end

  def create; end

  def edit; end

  def update; end

  def create_params
    params.require(:wordlink).permit(:english, :american, :class, :hint, :notes, :locale)
  end
end