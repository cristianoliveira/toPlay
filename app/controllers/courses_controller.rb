class CoursesController < InheritedResources::Base
  respond_to :json
  before_action :block_show_menu
  before_action :set_course, only: [:show, :subject_levels]

  def subject_levels
    @subject = @course.subjects.find_by_id(params[:subject_id])
    begin
      return respond_topics if params[:level_id]
      respond_levels
    rescue
      respond({ "error" => "No data found" })
    end
  end

  def levels
    @subject = Subject.find_by_id(params[:id])
    respond(@subject.levels.map{|obj| { "value" => obj,
                                        "url" => url_for(controller: "courses",
                                                         action: "topics",
                                                         id: obj.id) }})
  end

  def topics
    @level = Level.find_by_id(params[:id])
    respond(@level.topics.map{|obj| { "value" => obj,
                                        "url" => url_for(controller: "topics",
                                                         action: "show",
                                                         id: obj.id) }})
  end

  private
  def respond_levels
    respond(@subject.levels)
  end

  def respond_topics
    @level = @subject.levels.find_by_id(params[:level_id])
    respond(@level.topics)
  end

  def respond(result)
    object = { "result" => result }
    render json: object
  end

  def set_course
    @course = params[:course_id].present? ? Course.find(params[:course_id]) : Course.first
  end

  def block_show_menu
    @show_menu = false
  end
end
