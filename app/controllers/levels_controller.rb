class LevelsController < ApplicationController

  def get_for_menu
    @levels = Level.where(subject_id: params[:subject_id])
    result = @levels.map{|lvl| { "value" => lvl,
                                          "url" => url_for(controller: "topics",
                                                           action: "get_for_menu",
                                                           level_id: lvl.id)
                                        }
                                 }
    respond_to do |f|
      f.json { render json: { :result => result } }
    end
  end

end
