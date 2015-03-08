class ResumesController  < InheritedResources::Base

   def create
     create! do |format|
       if @resume.errors.any?
         format.html { render json: { "error" => @resume.errors.messages } , status: 422 }
       else
         format.html { render json: @resume }
       end
     end
   end

   def update
     update! do |format|
       if @resume.errors.any?
         format.html { render json: { "error" => @resume.errors.messages } , status: 422 }
       else
         format.html { render json: @resume }
       end
     end
   end


   private
   def permitted_params
     params.permit(:resume => [:user_id, :topic_id, :description])
   end
end
