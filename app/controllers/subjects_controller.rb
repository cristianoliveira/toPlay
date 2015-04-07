class SubjectsController < InheritedResources::Base
  respond_to :json

  before_action :get_subject

  def levels
    @levels = Level.where(subject_id: params[:subject_id])
    respond_to do |format|
      format.json { render json: @levels }
    end
  end

  private
  def get_subject
    @subject = Subject.find_by_course_id(params[:course_id])
  end

end
