module ApplicationHelper

    def set_show_menu(param)
       @show_menu = param
    end

    def show_menu?
        @show_menu |= false
        @show_menu
    end

    def respond_json_error(json_errors)
      render json: { "error" => json_errors } , status: 422 if json_errors.instance_of? String
      render json: { "error" => json_errors.messages } , status: 422 if json_errors.instance_of? ActiveModel::Errors
    end

end
