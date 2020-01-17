# frozen_string_literal: true

class SidebarController < ApplicationController
  include ApplicationHelper # only for x sampa to ipa lol

  def xs_to_ipa
    
  end

  def show
    render :inline => x_sampa_to_ipa(input: params[:xs])
  end
end