class MainController < ApplicationController

  before_action :set_show_menu

  def index
  end

  def about
  end

  def rank
  end

  def contact
  end

  private
  def set_show_menu
     @show_menu = false
  end
end
