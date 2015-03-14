class SubjectsController < InheritedResources::Base
  respond_to :json

  before_action :get_subject

  private
  def get_subject
    @subject = Subject.find_by_course_id(params[:course_id])
  end

end
