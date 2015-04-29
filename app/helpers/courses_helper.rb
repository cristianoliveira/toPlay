module CoursesHelper
  def first_active index
    'active' if index == 0
  end

  def get_subject
      if params[:subject_id]
          @subject = get_all_courses.subjects.find_by_id(params[:subject_id])
      end
  end

  def current_course
    @course ||= @topic.course if @topic
    @course ||= Course.first
    @course
  end
  
end
