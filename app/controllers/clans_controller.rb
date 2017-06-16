# frozen_string_literal: true
class ClansController < ApplicationController
  before_action :authenticate_user!
  rescue_from ActiveRecord::RecordNotFound, :with => :render_404

  def new
    @clan = Clan.new
    @clan.colour = '#009999'
  end

  def create
    @clan = Clan.new(clan_params)
    if @clan.save
      @cm = ClanMembership.new(clan: @clan, user: current_user, role: 'A')
      if @cm.save
        flash[:success] = 'Clan successfully created'
      else
        flash[:error] = 'Clan created but you could not be added. Please contact a staff member.'
      end
      redirect_to @clan
    else
      flash[:error] = 'Clan could not be saved'
      render 'new'
    end
  end

  def index
    @clans = Clan.all
  end

  def join
    # HANDLE CLAN PERMISSION TYPES
    @clan = Clan.find(params[:id])
    @membership = ClanMembership.new
    @membership.user = current_user
    @membership.clan = @clan
    if @membership.save
      flash[:success] = 'Clan joined'
    else
      flash[:error] = 'Could not join clan'
    end
    redirect_to @clan
  end

  def primary
    @clan = Clan.find(params[:id])
    if current_user.in_clan?(@clan) or not @clan.concrete_members?
      current_user.default_clan = if @clan.concrete_members?
                                    @clan
                                  else
                                    nil
                                  end
      if current_user.save
        flash[:success] = 'Primary clan has been set'
      else
        flash[:error] = 'Could not set primary clan'
      end
    else
      flash[:error] = 'You are not a member of this clan'
    end
    redirect_to @clan
  end

  def edit; end
  def update; end

  def show
    @clan = Clan.find(params[:id])
  end

  def render_404
    redirect_to clans_path
  end

  def destroy; end

  def clan_params
    params.require(:clan).permit(:name, :description, :permission, :symbol, :colour)
  end
end
