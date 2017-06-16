# frozen_string_literal: true
class ClansController < ApplicationController
  before_action :authenticate_user!

  def new
    @clan = Clan.new
    @clan.colour = '#99dddd'
  end

  def create
    @clan = Clan.new(clan_params)
    if @clan.save
      redirect_to @clan
    else
      render 'new'
    end
  end

  def index; end
  def edit; end
  def update; end

  def show
    @clan = Clan.find(params[:id])
  end

  def destroy; end

  def clan_params
    params.require(:clan).permit(:name, :description, :permission, :symbol, :colour)
  end
end