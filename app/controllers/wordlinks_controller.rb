# frozen_string_literal: true

class WordlinksController < ApplicationController
  def index
    respond_to do |format|
      format.html { @wordlinks = Wordlink.all }
      format.json { @wordlinks = Wordlink.search(params[:term]) }
    end
  end

  def show
    @wordlink = Wordlink.find_by(wlid: params[:id])
  end

  def new
    @wordlink = Wordlink.new
  end

  def create
    @wordlink = Wordlink.new(create_params)
    if @wordlink.save
      redirect_to @wordlink
    else
      render 'new'
    end
  end

  def edit; end

  def update; end

  private

  def create_params
    params.require(:wordlink).permit(:english, :american, :wc, :hint, :notes, :locale)
  end
end