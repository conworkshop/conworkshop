# frozen_string_literal: true
class ClansController < ApplicationController
  before_action :authenticate_user!

  def new
    @clan = Clan.new
    @clan.colour = '#99dddd'
  end
  def create; end
  def index; end
  def edit; end
  def update; end
  def show; end
  def destroy; end
end