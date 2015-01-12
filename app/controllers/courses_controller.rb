class CoursesController < InheritedResources::Base
  before_action :set_course, only: :show

  def set_course
    @course = params[:course_id].present? ? Course.find(params[:course_id]) : Course.first
  end
end
