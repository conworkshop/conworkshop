# frozen_string_literal: true
class LanguagesController < ApplicationController
  def index
    @languages = Language.includes(:lang_type, user: [:default_clan])
                         .order(:code).page(params[:page]).per(50)

    render 'index', locals: { languages_count: Language.count }
  end

  def show
    @language = Language.find_by(code: params[:id].upcase)
  end

  def new
    @language = Language.new
  end

  def create
    p = create_params

    p[:lang_type] = LangType.find_by_code(p[:lang_type])
    @language = Language.new(p)
    @language.user = current_user
    @language.status = :new_language

    if params[:unnamed]
      @language.name       = 'Unnamed'
      @language.nativename = 'Unnamed'
    end

    if @language.save
      redirect_to @language
    else
      render 'new'
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  def check_code
    render text: Language.exists?(code: params[:id].upcase) ? 0 : 1
  end

  private

  def create_params
    params.require(:language).permit(:code, :name, :nativename, :lang_type, :unnamed)
  end
end
