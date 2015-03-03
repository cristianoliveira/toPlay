module CoursesHelper
  def first_active index
    'active' if index == 0
  end

  def get_courses
    if !@course
      @course = params[:course_id].present? ? Course.find(params[:course_id]) : Course.first
    end
    @course
  end

  def get_subject
      if params[:subject_id]
          @subject = get_all_courses.subjects.find_by_id(params[:subject_id])
      end
  end

end
