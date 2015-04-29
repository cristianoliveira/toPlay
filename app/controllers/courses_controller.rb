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
    @course = Course.find(params[:id]) if params[:id].present?
    @course = Course.find(params[:course_id]) if params[:course_id].present?
    @course = Course.first if @course.nil?
  end

  def block_show_menu
    @show_menu = false
  end

  def authenticate_user! #avoid redirect
    return true
  end
end
