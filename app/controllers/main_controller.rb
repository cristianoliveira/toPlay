class MainController < ApplicationController
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
end
