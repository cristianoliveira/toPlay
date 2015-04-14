module ApplicationHelper

    def set_show_menu(param)
       @show_menu = param
    end

    def show_menu?
        @show_menu ||= false
        @show_menu
    end

    def respond_json(json)
      render json: { "result" => json }
    end

    def respond_json_error(json_errors)
      render json: { "error" => json_errors } , status: 422 if json_errors.instance_of? String
      render json: { "error" => json_errors.messages } , status: 422 if json_errors.instance_of? ActiveModel::Errors
    end

    def class_upvoted(object_vatable)
      return 'upvoted' if current_user.voted_up_on? object_vatable
    end
    
    def class_downvoted(object_vatable)
      return 'downvoted' if current_user.voted_down_on? object_vatable
    end
end
