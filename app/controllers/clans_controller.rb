# frozen_string_literal: true
class ClansController < ApplicationController
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
        flash[:success] = t('clans.new.success')
      else
        flash[:error] = t('clans.new.nojoin')
      end
      redirect_to @clan
    else
      flash[:error] = t('clans.new.fail')
      render 'new'
    end
  end

  def index
    @clans = Clan.all
  end

  def join_open(clan)
    @membership = ClanMembership.new(user: current_user, clan: clan)
    if @membership.save
      flash[:success] = t('clans.join.success')
    else
      flash[:error] = t('clans.join.fail')
    end
    redirect_to clan
  end

  def join_request(clan)
    @request = ClanRequest.new(user: current_user, clan: clan)
    if @request.save
      flash[:info] = t('clans.join.request.success')
    else
      flash[:error] = t('clans.join.request.fail')
    end
    redirect_to clan
  end

  def join
    @clan = Clan.find(params[:id])
    case @clan.permission
      when 'O'
        join_open(@clan)
      when 'R'
        join_request(@clan)
      else
        flash[:error] = t('clans.join.noinvite')
        redirect_to @clan
    end
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
        flash[:success] = t('clans.primary.success')
      else
        flash[:error] = t('clans.primary.fail')
      end
    else
      flash[:error] = t('clans.primary.nomember')
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
