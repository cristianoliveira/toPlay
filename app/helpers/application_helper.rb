module ApplicationHelper

    def set_show_menu(param)
       @show_menu = param
    end

    def show_menu?
        @show_menu |= false
        @show_menu
    end

end
