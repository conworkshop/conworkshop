# frozen_string_literal: true

class PhonesController < ApplicationController
  def index
    @poa = Phone.where(articulation: 'C').group(:col).select(:col).sort_by { |c| Phone::CONS_PLACE.index(c.col) }
    @back = Phone.where(articulation: 'V').group(:col).select(:col).sort_by { |c| Phone::VOWEL_BACK.index(c.col) }
    @consonants = Phone.where(articulation: 'C').group_by(&:row)
    @vowels = Phone.where(articulation: 'V').group_by(&:row)
  end

  def show
    @phone = Phone.find_by(code: params[:id])
  end

  def new
    @phone = Phone.new
  end

  def create
    @phone = Phone.new(create_params)
    if @phone.save
      redirect_to @phone
    else
      render 'new'
    end
  end

  def edit; end

  def update; end

  def destroy; end

  def create_params
    if params[:phone][:articulation] == 'C'
      params[:phone][:row] = params[:phone][:crow]
      params[:phone][:col] = params[:phone][:ccol]
    elsif params[:phone][:articulation] == 'V'
      params[:phone][:row] = params[:phone][:vrow]
      params[:phone][:col] = params[:phone][:vcol]
    end
    params.require(:phone).permit(:code, :ipa, :sampa, :col, :row, :voiceless, :rounded, :articulation, :name)
  end
end