class ResumesController  < InheritedResources::Base

  def create
    create! do | format |
      format.html
      format.json do
        if @resume.errors.any?
          render json: { "error" => @resume.errors.messages } , status: 422
        else
          render json: @resume
        end
      end
    end
  end

  def update
    update! do |format|
      format.html
      format.json do
        if @resume.errors.any?
          render json: { "error" => @resume.errors.messages } , status: 422
        else
          render json: @resume
        end
      end
    end
  end

  private
  def permitted_params
      params.permit(:resume => [:user_id, :topic_id, :description])
  end
end
