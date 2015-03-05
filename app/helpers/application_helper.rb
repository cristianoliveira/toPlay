module ApplicationHelper

    def set_show_menu(param)
       @show_menu = param
    end

    def show_menu?
        return @show_menu if defined? @show_menu
        true
    end
end
