# frozen_string_literal: true

class WordsController < ApplicationController
  before_action :define_language
  before_action :check_language, except: %i[index show]

  def index
    @words = Word.where(language: @language)
  end

  def show
    @word = Word.find_by(language: @language, wid: params[:id])
  end

  def new
    @word = Word.new
  end

  def create
    @word = Word.new(create_params)
    @word.language = @language
    @word.user = current_user
    if @word.save
      redirect_to language_word_path(@language, @word)
    else
      render 'new'
    end
  end

  def edit; end

  def update; end

  def destroy; end

  def settings; end

  private

  def create_params
    params.require(:word).permit(:head, :althead, :wc, :register, :ipa, :sampa, :etym, :notes, :sample, wordlinks: [])
  end

  def check_language
    redirect_to language_path(@language) unless current_user == @language.user
  end

  def define_language
    @language = Language.find_by(code: params[:language_id])
    redirect_to language_path(@params[:language_id]) unless @language
  end
end