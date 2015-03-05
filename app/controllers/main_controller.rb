class MainController < ApplicationController

  before_action :set_show_menu

  def index
  end

  def about
  end

  def courses
  end

  def rank
  end

  def contact

    if params[:email]
       raise 'sss'
    end

  end

  private
  def set_show_menu
     @show_menu = false
  end
end
